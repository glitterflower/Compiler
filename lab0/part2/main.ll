declare i32 @getint()
declare void @putint(i32)
declare void @putch(i32)

@f = global [100 x i32] zeroinitializer

define i32 @main() {
entry:
    %i = alloca i32
    %n = call i32 @getint()
    %j = alloca i32
    %len = alloca i32
    %c = alloca i32

    store i32 2, ptr %i
    store i32 1, ptr getelementptr inbounds ([100 x i32], ptr @f, i64 0, i64 0)
    store i32 1, ptr %len
    
    br label %while1

while1:
    %i_val = load i32, ptr %i
    %cmp1 = icmp sle i32 %i_val, %n
    br i1 %cmp1, label %while1_body, label %while1_end

while1_body:
    store i32 0, ptr %j
    store i32 0, ptr %c
    br label %while2

while2:
    %j_val = load i32, ptr %j
    %len_val = load i32, ptr %len
    %cmp2 = icmp slt i32 %j_val, %len_val
    br i1 %cmp2, label %while2_body, label %while2_end

while2_body:
    %j_val2 = load i32, ptr %j
    %j_val2_ext = zext i32 %j_val2 to i64
    %f_j = getelementptr inbounds [100 x i32], ptr @f, i64 0, i64 %j_val2_ext
    %f_j_val = load i32, ptr %f_j
    %i_val2 = load i32, ptr %i
    %c_val = load i32, ptr %c
    %mul = mul i32 %f_j_val, %i_val2
    %add = add i32 %mul, %c_val
    store i32 %add, ptr %c
    %c_val2 = load i32, ptr %c
    %mod = srem i32 %c_val2, 10
    %j_val3 = load i32, ptr %j
    %j_val3_ext = zext i32 %j_val3 to i64
    %f_j2 = getelementptr inbounds [100 x i32], ptr @f, i64 0, i64 %j_val3_ext
    store i32 %mod, ptr %f_j2
    %c_val3 = load i32, ptr %c
    %div = sdiv i32 %c_val3, 10
    store i32 %div, ptr %c
    %j_val4 = load i32, ptr %j
    %j_inc = add i32 %j_val4, 1
    store i32 %j_inc, ptr %j
    br label %while2

while2_end:
    br label %while3

while3:
    %c_val4 = load i32, ptr %c
    %cmp3 = icmp sgt i32 %c_val4, 0
    br i1 %cmp3, label %while3_body, label %while3_end

while3_body:
    %c_val5 = load i32, ptr %c
    %mod2 = srem i32 %c_val5, 10
    %len_val2 = load i32, ptr %len
    %len_val2_ext = zext i32 %len_val2 to i64
    %f_len = getelementptr inbounds [100 x i32], ptr @f, i64 0, i64 %len_val2_ext
    store i32 %mod2, ptr %f_len
    %c_val6 = load i32, ptr %c
    %div2 = sdiv i32 %c_val6, 10
    store i32 %div2, ptr %c
    %len_val3 = load i32, ptr %len
    %len_inc = add i32 %len_val3, 1
    store i32 %len_inc, ptr %len
    br label %while3

while3_end:
    %i_val3 = load i32, ptr %i
    %i_inc = add i32 %i_val3, 1
    store i32 %i_inc, ptr %i
    br label %while1

while1_end:
    br label %while4

while4:
    %len_val4 = load i32, ptr %len
    %cmp4 = icmp sgt i32 %len_val4, 0
    br i1 %cmp4, label %while4_body, label %while4_end

while4_body:
    %len_val5 = load i32, ptr %len
    %len_dec = sub i32 %len_val5, 1
    store i32 %len_dec, ptr %len
    %len_val6 = load i32, ptr %len
    %len_val6_ext = zext i32 %len_val6 to i64
    %f_len2 = getelementptr inbounds [100 x i32], ptr @f, i64 0, i64 %len_val6_ext
    %f_len_val = load i32, ptr %f_len2
    call void @putint(i32 %f_len_val)
    br label %while4

while4_end:
    call void @putch(i32 10)
    ret i32 0
}