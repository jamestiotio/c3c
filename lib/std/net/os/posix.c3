module std::net::os @if(env::POSIX && SUPPORTS_INET);
import libc;

const int F_GETFL = 3;
const int F_SETFL = 4;

distinct NativeSocket = inline Fd;

struct Posix_pollfd
{
	CInt fd;
	CUShort events;
	CUShort revents;
}

def Posix_nfds_t = CUInt;

extern fn CInt connect(NativeSocket socket, SockAddrPtr address, Socklen_t address_len);
extern fn NativeSocket socket(AIFamily af, AISockType type, AIProtocol ip_protocol) @extern("socket");
extern fn int fcntl(NativeSocket socket, int cmd, ...) @extern("fcntl");
extern fn CInt bind(NativeSocket socket, SockAddrPtr address, Socklen_t address_len) @extern("bind");
extern fn CInt listen(NativeSocket socket, CInt backlog) @extern("listen");
extern fn NativeSocket accept(NativeSocket socket, SockAddrPtr address, Socklen_t* address_len) @extern("accept");
extern fn CInt poll(Posix_pollfd* fds, Posix_nfds_t nfds, CInt timeout);

const CUShort POLLIN      = 0x0001;
const CUShort POLLPRI     = 0x0002;
const CUShort POLLOUT     = 0x0004;
const CUShort POLLERR     = 0x0008;
const CUShort POLLHUP     = 0x0010;
const CUShort POLLNVAL    = 0x0020;

fn anyfault convert_error(Errno error)
{
	switch (error)
	{
		case errno::EACCES: return IoError.NO_PERMISSION;
		case errno::EADDRINUSE: return NetError.ADDRESS_IN_USE;
		case errno::EALREADY: return NetError.CONNECTION_ALREADY_IN_PROGRESS;
		case errno::EBADF: return NetError.BAD_SOCKET_DESCRIPTOR;
		case errno::ECONNREFUSED: return NetError.CONNECTION_REFUSED;
		case errno::EISCONN: return NetError.ALREADY_CONNECTED;
		case errno::ENETUNREACH: return NetError.NETWORK_UNREACHABLE;
		case errno::ENOTSOCK: return NetError.NOT_A_SOCKET;
		case errno::EINTR: return IoError.INTERRUPTED;
        case errno::EWOULDBLOCK: return IoError.WOULD_BLOCK;
		case errno::EOPNOTSUPP: return NetError.OPERATION_NOT_SUPPORTED_ON_SOCKET;
		case errno::ETIMEDOUT: return NetError.CONNECTION_TIMED_OUT;
		default: return IoError.GENERAL_ERROR;
	}
}

fn anyfault socket_error()
{
	return convert_error(libc::errno());
}

macro void! NativeSocket.close(self)
{
	if (libc::close(self))
	{
		if (libc::errno() == errno::EBADF) return NetError.INVALID_SOCKET?;
		return NetError.GENERAL_ERROR?;
	}
}

macro void! NativeSocket.set_non_blocking(self, bool non_blocking)
{
	int flags = fcntl(self, F_GETFL, 0);
	if (non_blocking)
	{
		if (flags & O_NONBLOCK) return;
		flags |= O_NONBLOCK;
	}
	else
	{
		if (!(flags & O_NONBLOCK)) return;
		flags &= ~(int)O_NONBLOCK;
	}
	if (fcntl(self, F_SETFL, flags) == -1)
	{
		if (libc::errno() == errno::EBADF) return NetError.INVALID_SOCKET?;
		return NetError.GENERAL_ERROR?;
	}
}

macro bool NativeSocket.is_non_blocking(self)
{
	return fcntl(self, F_GETFL, 0) & O_NONBLOCK != 0;
}
