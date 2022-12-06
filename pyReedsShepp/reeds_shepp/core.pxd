cimport cython

ctypedef int (*ReedsSheppPathSamplingCallback)(double q[3], void* user_data)
ctypedef int (*ReedsSheppPathTypeCallback) (int t, void* user_data)
ctypedef double (*ReedsSheppPathLengthCallback) (double t, void* user_data)
cdef extern from "reeds_shepp.h":
    cdef cppclass ReedsSheppStateSpace:
        ReedsSheppStateSpace(double turningRadius)
        double distance(double q0[3], double q1[3])
        void sample(double q0[3], double q1[3], double step_size, ReedsSheppPathSamplingCallback cb, void* user_data)
        void type(double q0[3], double q1[3], ReedsSheppPathTypeCallback cb, void* user_data)
        void length(double q0[3], double q1[3], ReedsSheppPathLengthCallback cb, void* user_data)
        void type_length(double q0[3], double q1[3], ReedsSheppPathTypeCallback cb1, void* user_data1, ReedsSheppPathLengthCallback cb2, void* user_data2);
        void type_length_sample(double q0[3], double q1[3], double step_size, ReedsSheppPathTypeCallback cb1, void* user_data1, ReedsSheppPathLengthCallback cb2, void* user_data2, ReedsSheppPathSamplingCallback cb3, void* user_data3);
       

cdef inline int sample_cb(double q[3], void* f):
    qn = (q[0], q[1], q[2])
    return (<object>f)(qn)

cdef inline int type_cb(int t, void* f):
    return (<object>f)(t)

cdef inline double length_cb(double t, void* f):
    return (<object>f)(t)
