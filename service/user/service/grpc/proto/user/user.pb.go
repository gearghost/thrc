// Code generated by protoc-gen-go. DO NOT EDIT.
// source: user.proto

package user // import "."

import proto "github.com/golang/protobuf/proto"
import fmt "fmt"
import math "math"

import (
	context "golang.org/x/net/context"
	grpc "google.golang.org/grpc"
)

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the proto package it is being compiled against.
// A compilation error at this line likely means your copy of the
// proto package needs to be updated.
const _ = proto.ProtoPackageIsVersion2 // please upgrade the proto package

type UserReq struct {
	UserID               string   `protobuf:"bytes,1,opt,name=UserID,proto3" json:"UserID,omitempty"`
	Name                 string   `protobuf:"bytes,2,opt,name=Name,proto3" json:"Name,omitempty"`
	Mobile               string   `protobuf:"bytes,3,opt,name=Mobile,proto3" json:"Mobile,omitempty"`
	Email                string   `protobuf:"bytes,4,opt,name=Email,proto3" json:"Email,omitempty"`
	Sex                  string   `protobuf:"bytes,5,opt,name=Sex,proto3" json:"Sex,omitempty"`
	Birthday             string   `protobuf:"bytes,6,opt,name=Birthday,proto3" json:"Birthday,omitempty"`
	Age                  string   `protobuf:"bytes,7,opt,name=Age,proto3" json:"Age,omitempty"`
	AvatarURL            string   `protobuf:"bytes,8,opt,name=AvatarURL,proto3" json:"AvatarURL,omitempty"`
	Remark               string   `protobuf:"bytes,9,opt,name=Remark,proto3" json:"Remark,omitempty"`
	RegisterTime         string   `protobuf:"bytes,10,opt,name=RegisterTime,proto3" json:"RegisterTime,omitempty"`
	UpdateTime           string   `protobuf:"bytes,11,opt,name=UpdateTime,proto3" json:"UpdateTime,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *UserReq) Reset()         { *m = UserReq{} }
func (m *UserReq) String() string { return proto.CompactTextString(m) }
func (*UserReq) ProtoMessage()    {}
func (*UserReq) Descriptor() ([]byte, []int) {
	return fileDescriptor_user_69b105032e11213d, []int{0}
}
func (m *UserReq) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_UserReq.Unmarshal(m, b)
}
func (m *UserReq) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_UserReq.Marshal(b, m, deterministic)
}
func (dst *UserReq) XXX_Merge(src proto.Message) {
	xxx_messageInfo_UserReq.Merge(dst, src)
}
func (m *UserReq) XXX_Size() int {
	return xxx_messageInfo_UserReq.Size(m)
}
func (m *UserReq) XXX_DiscardUnknown() {
	xxx_messageInfo_UserReq.DiscardUnknown(m)
}

var xxx_messageInfo_UserReq proto.InternalMessageInfo

func (m *UserReq) GetUserID() string {
	if m != nil {
		return m.UserID
	}
	return ""
}

func (m *UserReq) GetName() string {
	if m != nil {
		return m.Name
	}
	return ""
}

func (m *UserReq) GetMobile() string {
	if m != nil {
		return m.Mobile
	}
	return ""
}

func (m *UserReq) GetEmail() string {
	if m != nil {
		return m.Email
	}
	return ""
}

func (m *UserReq) GetSex() string {
	if m != nil {
		return m.Sex
	}
	return ""
}

func (m *UserReq) GetBirthday() string {
	if m != nil {
		return m.Birthday
	}
	return ""
}

func (m *UserReq) GetAge() string {
	if m != nil {
		return m.Age
	}
	return ""
}

func (m *UserReq) GetAvatarURL() string {
	if m != nil {
		return m.AvatarURL
	}
	return ""
}

func (m *UserReq) GetRemark() string {
	if m != nil {
		return m.Remark
	}
	return ""
}

func (m *UserReq) GetRegisterTime() string {
	if m != nil {
		return m.RegisterTime
	}
	return ""
}

func (m *UserReq) GetUpdateTime() string {
	if m != nil {
		return m.UpdateTime
	}
	return ""
}

type UserResp struct {
	Code                 int32    `protobuf:"varint,1,opt,name=Code,proto3" json:"Code,omitempty"`
	Message              string   `protobuf:"bytes,2,opt,name=Message,proto3" json:"Message,omitempty"`
	Data                 string   `protobuf:"bytes,3,opt,name=Data,proto3" json:"Data,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *UserResp) Reset()         { *m = UserResp{} }
func (m *UserResp) String() string { return proto.CompactTextString(m) }
func (*UserResp) ProtoMessage()    {}
func (*UserResp) Descriptor() ([]byte, []int) {
	return fileDescriptor_user_69b105032e11213d, []int{1}
}
func (m *UserResp) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_UserResp.Unmarshal(m, b)
}
func (m *UserResp) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_UserResp.Marshal(b, m, deterministic)
}
func (dst *UserResp) XXX_Merge(src proto.Message) {
	xxx_messageInfo_UserResp.Merge(dst, src)
}
func (m *UserResp) XXX_Size() int {
	return xxx_messageInfo_UserResp.Size(m)
}
func (m *UserResp) XXX_DiscardUnknown() {
	xxx_messageInfo_UserResp.DiscardUnknown(m)
}

var xxx_messageInfo_UserResp proto.InternalMessageInfo

func (m *UserResp) GetCode() int32 {
	if m != nil {
		return m.Code
	}
	return 0
}

func (m *UserResp) GetMessage() string {
	if m != nil {
		return m.Message
	}
	return ""
}

func (m *UserResp) GetData() string {
	if m != nil {
		return m.Data
	}
	return ""
}

func init() {
	proto.RegisterType((*UserReq)(nil), "user.UserReq")
	proto.RegisterType((*UserResp)(nil), "user.UserResp")
}

// Reference imports to suppress errors if they are not otherwise used.
var _ context.Context
var _ grpc.ClientConn

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
const _ = grpc.SupportPackageIsVersion4

// UserClient is the client API for User service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
type UserClient interface {
	CreateUser(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error)
	GetUserByUID(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error)
	GetUserByMobile(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error)
	UpdateUserByUID(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error)
	UpdateUserByMobile(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error)
	UpdateUserByEmail(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error)
	UpdateAvatarByUID(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error)
}

type userClient struct {
	cc *grpc.ClientConn
}

func NewUserClient(cc *grpc.ClientConn) UserClient {
	return &userClient{cc}
}

func (c *userClient) CreateUser(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error) {
	out := new(UserResp)
	err := c.cc.Invoke(ctx, "/user.User/CreateUser", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *userClient) GetUserByUID(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error) {
	out := new(UserResp)
	err := c.cc.Invoke(ctx, "/user.User/GetUserByUID", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *userClient) GetUserByMobile(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error) {
	out := new(UserResp)
	err := c.cc.Invoke(ctx, "/user.User/GetUserByMobile", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *userClient) UpdateUserByUID(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error) {
	out := new(UserResp)
	err := c.cc.Invoke(ctx, "/user.User/UpdateUserByUID", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *userClient) UpdateUserByMobile(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error) {
	out := new(UserResp)
	err := c.cc.Invoke(ctx, "/user.User/UpdateUserByMobile", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *userClient) UpdateUserByEmail(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error) {
	out := new(UserResp)
	err := c.cc.Invoke(ctx, "/user.User/UpdateUserByEmail", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *userClient) UpdateAvatarByUID(ctx context.Context, in *UserReq, opts ...grpc.CallOption) (*UserResp, error) {
	out := new(UserResp)
	err := c.cc.Invoke(ctx, "/user.User/UpdateAvatarByUID", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// UserServer is the server API for User service.
type UserServer interface {
	CreateUser(context.Context, *UserReq) (*UserResp, error)
	GetUserByUID(context.Context, *UserReq) (*UserResp, error)
	GetUserByMobile(context.Context, *UserReq) (*UserResp, error)
	UpdateUserByUID(context.Context, *UserReq) (*UserResp, error)
	UpdateUserByMobile(context.Context, *UserReq) (*UserResp, error)
	UpdateUserByEmail(context.Context, *UserReq) (*UserResp, error)
	UpdateAvatarByUID(context.Context, *UserReq) (*UserResp, error)
}

func RegisterUserServer(s *grpc.Server, srv UserServer) {
	s.RegisterService(&_User_serviceDesc, srv)
}

func _User_CreateUser_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UserReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(UserServer).CreateUser(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/user.User/CreateUser",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(UserServer).CreateUser(ctx, req.(*UserReq))
	}
	return interceptor(ctx, in, info, handler)
}

func _User_GetUserByUID_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UserReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(UserServer).GetUserByUID(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/user.User/GetUserByUID",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(UserServer).GetUserByUID(ctx, req.(*UserReq))
	}
	return interceptor(ctx, in, info, handler)
}

func _User_GetUserByMobile_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UserReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(UserServer).GetUserByMobile(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/user.User/GetUserByMobile",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(UserServer).GetUserByMobile(ctx, req.(*UserReq))
	}
	return interceptor(ctx, in, info, handler)
}

func _User_UpdateUserByUID_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UserReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(UserServer).UpdateUserByUID(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/user.User/UpdateUserByUID",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(UserServer).UpdateUserByUID(ctx, req.(*UserReq))
	}
	return interceptor(ctx, in, info, handler)
}

func _User_UpdateUserByMobile_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UserReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(UserServer).UpdateUserByMobile(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/user.User/UpdateUserByMobile",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(UserServer).UpdateUserByMobile(ctx, req.(*UserReq))
	}
	return interceptor(ctx, in, info, handler)
}

func _User_UpdateUserByEmail_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UserReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(UserServer).UpdateUserByEmail(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/user.User/UpdateUserByEmail",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(UserServer).UpdateUserByEmail(ctx, req.(*UserReq))
	}
	return interceptor(ctx, in, info, handler)
}

func _User_UpdateAvatarByUID_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UserReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(UserServer).UpdateAvatarByUID(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/user.User/UpdateAvatarByUID",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(UserServer).UpdateAvatarByUID(ctx, req.(*UserReq))
	}
	return interceptor(ctx, in, info, handler)
}

var _User_serviceDesc = grpc.ServiceDesc{
	ServiceName: "user.User",
	HandlerType: (*UserServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "CreateUser",
			Handler:    _User_CreateUser_Handler,
		},
		{
			MethodName: "GetUserByUID",
			Handler:    _User_GetUserByUID_Handler,
		},
		{
			MethodName: "GetUserByMobile",
			Handler:    _User_GetUserByMobile_Handler,
		},
		{
			MethodName: "UpdateUserByUID",
			Handler:    _User_UpdateUserByUID_Handler,
		},
		{
			MethodName: "UpdateUserByMobile",
			Handler:    _User_UpdateUserByMobile_Handler,
		},
		{
			MethodName: "UpdateUserByEmail",
			Handler:    _User_UpdateUserByEmail_Handler,
		},
		{
			MethodName: "UpdateAvatarByUID",
			Handler:    _User_UpdateAvatarByUID_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "user.proto",
}

func init() { proto.RegisterFile("user.proto", fileDescriptor_user_69b105032e11213d) }

var fileDescriptor_user_69b105032e11213d = []byte{
	// 346 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0x94, 0x52, 0x4d, 0x4f, 0xc2, 0x40,
	0x10, 0x15, 0x28, 0xa5, 0x8c, 0xf8, 0x35, 0x31, 0x66, 0x43, 0x8c, 0x31, 0x3d, 0x79, 0x11, 0x13,
	0xd4, 0x93, 0x27, 0x3e, 0x8c, 0x21, 0x01, 0x0f, 0xd5, 0x5e, 0xbc, 0x2d, 0x61, 0x52, 0x1b, 0x69,
	0x5a, 0xb7, 0xab, 0x91, 0x1f, 0xe3, 0x8f, 0xf4, 0x1f, 0x98, 0x9d, 0x2d, 0x58, 0x4f, 0xd6, 0xdb,
	0x7b, 0xaf, 0xef, 0x75, 0x67, 0xdf, 0x2c, 0xc0, 0x5b, 0x4e, 0xaa, 0x97, 0xa9, 0x54, 0xa7, 0xe8,
	0x18, 0xec, 0x7f, 0xd6, 0xa1, 0x15, 0xe6, 0xa4, 0x02, 0x7a, 0xc5, 0x23, 0x70, 0x0d, 0x9c, 0x8c,
	0x45, 0xed, 0xb4, 0x76, 0xd6, 0x0e, 0x0a, 0x86, 0x08, 0xce, 0xbd, 0x4c, 0x48, 0xd4, 0x59, 0x65,
	0x6c, 0xbc, 0xb3, 0x74, 0x1e, 0x2f, 0x49, 0x34, 0xac, 0xd7, 0x32, 0x3c, 0x84, 0xe6, 0x6d, 0x22,
	0xe3, 0xa5, 0x70, 0x58, 0xb6, 0x04, 0xf7, 0xa1, 0xf1, 0x40, 0x1f, 0xa2, 0xc9, 0x9a, 0x81, 0xd8,
	0x05, 0x6f, 0x18, 0x2b, 0xfd, 0xbc, 0x90, 0x2b, 0xe1, 0xb2, 0xbc, 0xe1, 0xc6, 0x3d, 0x88, 0x48,
	0xb4, 0xac, 0x7b, 0x10, 0x11, 0x1e, 0x43, 0x7b, 0xf0, 0x2e, 0xb5, 0x54, 0x61, 0x30, 0x15, 0x1e,
	0xeb, 0x3f, 0x82, 0x99, 0x25, 0xa0, 0x44, 0xaa, 0x17, 0xd1, 0xb6, 0xb3, 0x58, 0x86, 0x3e, 0x74,
	0x02, 0x8a, 0xe2, 0x5c, 0x93, 0x7a, 0x8c, 0x13, 0x12, 0xc0, 0x5f, 0x7f, 0x69, 0x78, 0x02, 0x10,
	0x66, 0x0b, 0xa9, 0x89, 0x1d, 0xdb, 0xec, 0x28, 0x29, 0xfe, 0x14, 0x3c, 0x5b, 0x4f, 0x9e, 0x99,
	0x1e, 0x46, 0xe9, 0x82, 0xb8, 0x9d, 0x66, 0xc0, 0x18, 0x05, 0xb4, 0x66, 0x94, 0xe7, 0x32, 0x5a,
	0xd7, 0xb3, 0xa6, 0xc6, 0x3d, 0x96, 0x5a, 0x16, 0xfd, 0x30, 0xee, 0x7f, 0xd5, 0xc1, 0x31, 0xbf,
	0xc3, 0x73, 0x80, 0x91, 0x22, 0xa9, 0x89, 0xd9, 0x4e, 0x8f, 0xf7, 0x52, 0xec, 0xa1, 0xbb, 0x5b,
	0xa6, 0x79, 0xe6, 0x6f, 0xe1, 0x05, 0x74, 0xee, 0x48, 0x1b, 0x61, 0xb8, 0x0a, 0x27, 0xe3, 0xbf,
	0x03, 0x7d, 0xd8, 0xdb, 0x04, 0x8a, 0xcd, 0x54, 0xc9, 0xd8, 0x8b, 0xff, 0xe3, 0x9c, 0x6b, 0xc0,
	0x72, 0xa6, 0xea, 0x51, 0x57, 0x70, 0x50, 0x8e, 0xd9, 0x47, 0x52, 0x3d, 0x65, 0x57, 0x5f, 0x6d,
	0xc4, 0xa1, 0xf7, 0xe4, 0xf6, 0x6e, 0x8c, 0x38, 0x77, 0xf9, 0xe1, 0x5f, 0x7e, 0x07, 0x00, 0x00,
	0xff, 0xff, 0x7d, 0x72, 0x80, 0x07, 0x06, 0x03, 0x00, 0x00,
}
