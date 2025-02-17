module math_tests;
import std::math;

fn void! test_abs() @test
{
	int x = -21;
	assert(math::abs(x) == 21);
	double y = -123.0;
	assert(math::abs(y) == 123.0);
	float z = -21.0f;
	assert(math::abs(z) == 21.0f);
	$assert @typeis(math::abs(z), float);
	int[<3>] xx = { -1, -1000, 1000 };
	assert(math::abs(xx) == int[<3>] { 1, 1000, 1000 });
	double[<3>] yy = { -1, -0.5, 1000 };
	assert(math::abs(yy) == double[<3>] { 1, 0.5, 1000 });
}

fn void! test_atan() @test
{
	int x = 231;
	assert(math::atan(x) == 1.5664673495078372);
	x = 1;
	assert(math::atan(x) == 0.7853981633974483);
	x = 0;
	assert(math::atan(x) == 0.0);
	x = -1;
	assert(math::atan(x) == -0.7853981633974483);
	x = -231;
	assert(math::atan(x) == -1.5664673495078372);
	float f = 0;
	assert(math::atan(f) == 0.0f);
	f = 1;
	assert(math::atan(f) == 0.7853981633974483f);
	f = -1;
	assert(math::atan(f) == -0.7853981633974483f);
	assert(@typeis(math::atan(f), float));
	double d = 0;
	assert(math::atan(d) == 0.0);
	d = 1;
	assert(math::atan(d) == 0.7853981633974483);
	d = -1;
	assert(math::atan(d) == -0.7853981633974483);
	assert(@typeis(math::atan(d), double));
}

fn void! test_ceil() @test
{
	double d = -123.1;
	assert(math::ceil(d) == -123.0);
	d = 123.1;
	assert(math::ceil(d) == 124.0);
	d = 0.1;
	assert(math::ceil(d) == 1);
	d = -0.9;
	assert(math::ceil(d) == 0);
	$assert @typeis(math::ceil(d), double);
	float f = -123.1f;
	assert(math::ceil(f) == -123.0f);
	f = 123.1f;
	assert(math::ceil(f) == 124.0f);
	f = 0.1f;
	assert(math::ceil(f) == 1.0f);
	f = -0.9f;
	assert(math::ceil(f) == 0.0f);
	$assert @typeis(math::ceil(f), float);
	double[<5>] vec = { -123.1, 123.1, 0.1, -0.9, 0 };
	assert(math::ceil(vec) == double[<5>] { -123, 124, 1, 0, 0 });
}

fn void! test_floor() @test
{
	double d = -123.1;
	assert(math::floor(d) == -124.0);
	d = 123.1;
	assert(math::floor(d) == 123.0);
	d = 0.9;
	assert(math::floor(d) == 0);
	d = -0.1;
	assert(math::floor(d) == -1);
	$assert @typeis(math::floor(d), double);
	float f = -123.1f;
	assert(math::floor(f) == -124.0f);
	f = 123.1f;
	assert(math::floor(f) == 123.0f);
	f = 0.9f;
	assert(math::floor(f) == 0.0f);
	f = -0.1f;
	assert(math::floor(f) == -1.0f);
	$assert @typeis(math::floor(f), float);
	double[<5>] vec = { -123.1, 123.1, 0.9, -0.1, 0 };
	assert(math::floor(vec) == double[<5>] { -124, 123, 0, -1, 0 });
}

fn void! test_log() @test
{
	double x = math::E;
	assert(math::log(x, x) == 1.0);
	float y = math::E;
	assert(math::log(y, y) == 1.0f);
	$assert @typeis(math::log(y, y), float);
	double[<3>] xx = { 2, 4, 8 };
	assert(math::log(xx, 2) == double[<3>] { 1.0, 2.0, 3.0 });
	float[<3>] yy = { 10, 100, 1000 };
	assert(math::log(yy, 10) == float[<3>] { 1.0, 2.0, 3.0 });
}

fn void! test_sign() @test
{
	int x = -21;
	assert(math::sign(x) == -1);
	x = 238219382;
	assert(math::sign(x) == 1);
	x = 0;
	assert(math::sign(x) == 0);
	uint y = 23;
	assert(math::sign(y) == 1);
	y = 0;
	assert(math::sign(y) == 0);
	y = (uint)-21;
	assert(math::sign(y) == 1);
	assert(@typeis(math::sign(y), uint));
}

fn void! test_trunc() @test
{
	double d = -123.9;
	assert(math::trunc(d) == -123.0);
	d = 123.1;
	assert(math::trunc(d) == 123.0);
	d = 0.9;
	assert(math::trunc(d) == 0);
	d = -0.9;
	assert(math::trunc(d) == 0);
	$assert @typeis(math::trunc(d), double);
	float f = -123.9f;
	assert(math::trunc(f) == -123.0f);
	f = 123.9f;
	assert(math::trunc(f) == 123.0f);
	f = 0.9f;
	assert(math::trunc(f) == 0.0f);
	f = -0.9f;
	assert(math::trunc(f) == -0.0f);
	$assert @typeis(math::trunc(f), float);
	double[<5>] vec = { -123.9, 123.9, 0.9, -0.9, 0 };
	assert(math::trunc(vec) == double[<5>] { -123, 123, 0, 0, 0 });
}