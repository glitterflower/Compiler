; ModuleID = 'main1.bc'
source_filename = "main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32* noundef nonnull %1)
  %3 = load i32, i32* %1, align 4
  %.not6 = icmp slt i32 %3, 2
  br i1 %.not6, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  %4 = add i32 %3, -1
  %min.iters.check = icmp ult i32 %4, 8
  br i1 %min.iters.check, label %.lr.ph.preheader11, label %vector.ph

vector.ph:                                        ; preds = %.lr.ph.preheader
  %n.vec = and i32 %4, -8
  %ind.end = or i32 %n.vec, 2
  %5 = add i32 %n.vec, -8
  %6 = lshr exact i32 %5, 3
  %7 = add nuw nsw i32 %6, 1
  %xtraiter = and i32 %7, 3
  %8 = icmp ult i32 %5, 24
  br i1 %8, label %middle.block.unr-lcssa, label %vector.ph.new

vector.ph.new:                                    ; preds = %vector.ph
  %unroll_iter = and i32 %7, 1073741820
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph.new
  %vec.phi = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %vector.ph.new ], [ %15, %vector.body ]
  %vec.phi9 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %vector.ph.new ], [ %16, %vector.body ]
  %vec.ind = phi <4 x i32> [ <i32 2, i32 3, i32 4, i32 5>, %vector.ph.new ], [ %vec.ind.next.3, %vector.body ]
  %niter = phi i32 [ 0, %vector.ph.new ], [ %niter.next.3, %vector.body ]
  %step.add = add <4 x i32> %vec.ind, <i32 4, i32 4, i32 4, i32 4>
  %9 = mul <4 x i32> %vec.phi, %vec.ind
  %10 = mul <4 x i32> %vec.phi9, %step.add
  %vec.ind.next = add <4 x i32> %vec.ind, <i32 8, i32 8, i32 8, i32 8>
  %step.add.1 = add <4 x i32> %vec.ind, <i32 12, i32 12, i32 12, i32 12>
  %11 = mul <4 x i32> %9, %vec.ind.next
  %12 = mul <4 x i32> %10, %step.add.1
  %vec.ind.next.1 = add <4 x i32> %vec.ind, <i32 16, i32 16, i32 16, i32 16>
  %step.add.2 = add <4 x i32> %vec.ind, <i32 20, i32 20, i32 20, i32 20>
  %13 = mul <4 x i32> %11, %vec.ind.next.1
  %14 = mul <4 x i32> %12, %step.add.2
  %vec.ind.next.2 = add <4 x i32> %vec.ind, <i32 24, i32 24, i32 24, i32 24>
  %step.add.3 = add <4 x i32> %vec.ind, <i32 28, i32 28, i32 28, i32 28>
  %15 = mul <4 x i32> %13, %vec.ind.next.2
  %16 = mul <4 x i32> %14, %step.add.3
  %vec.ind.next.3 = add <4 x i32> %vec.ind, <i32 32, i32 32, i32 32, i32 32>
  %niter.next.3 = add i32 %niter, 4
  %niter.ncmp.3 = icmp eq i32 %niter.next.3, %unroll_iter
  br i1 %niter.ncmp.3, label %middle.block.unr-lcssa, label %vector.body, !llvm.loop !6

middle.block.unr-lcssa:                           ; preds = %vector.body, %vector.ph
  %.lcssa13.ph = phi <4 x i32> [ undef, %vector.ph ], [ %15, %vector.body ]
  %.lcssa12.ph = phi <4 x i32> [ undef, %vector.ph ], [ %16, %vector.body ]
  %vec.phi.unr = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %vector.ph ], [ %15, %vector.body ]
  %vec.phi9.unr = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %vector.ph ], [ %16, %vector.body ]
  %vec.ind.unr = phi <4 x i32> [ <i32 2, i32 3, i32 4, i32 5>, %vector.ph ], [ %vec.ind.next.3, %vector.body ]
  %lcmp.mod.not = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod.not, label %middle.block, label %vector.body.epil

vector.body.epil:                                 ; preds = %middle.block.unr-lcssa, %vector.body.epil
  %vec.phi.epil = phi <4 x i32> [ %17, %vector.body.epil ], [ %vec.phi.unr, %middle.block.unr-lcssa ]
  %vec.phi9.epil = phi <4 x i32> [ %18, %vector.body.epil ], [ %vec.phi9.unr, %middle.block.unr-lcssa ]
  %vec.ind.epil = phi <4 x i32> [ %vec.ind.next.epil, %vector.body.epil ], [ %vec.ind.unr, %middle.block.unr-lcssa ]
  %epil.iter = phi i32 [ %epil.iter.next, %vector.body.epil ], [ 0, %middle.block.unr-lcssa ]
  %step.add.epil = add <4 x i32> %vec.ind.epil, <i32 4, i32 4, i32 4, i32 4>
  %17 = mul <4 x i32> %vec.phi.epil, %vec.ind.epil
  %18 = mul <4 x i32> %vec.phi9.epil, %step.add.epil
  %vec.ind.next.epil = add <4 x i32> %vec.ind.epil, <i32 8, i32 8, i32 8, i32 8>
  %epil.iter.next = add i32 %epil.iter, 1
  %epil.iter.cmp.not = icmp eq i32 %epil.iter.next, %xtraiter
  br i1 %epil.iter.cmp.not, label %middle.block, label %vector.body.epil, !llvm.loop !9

middle.block:                                     ; preds = %vector.body.epil, %middle.block.unr-lcssa
  %.lcssa13 = phi <4 x i32> [ %.lcssa13.ph, %middle.block.unr-lcssa ], [ %17, %vector.body.epil ]
  %.lcssa12 = phi <4 x i32> [ %.lcssa12.ph, %middle.block.unr-lcssa ], [ %18, %vector.body.epil ]
  %bin.rdx = mul <4 x i32> %.lcssa12, %.lcssa13
  %19 = call i32 @llvm.vector.reduce.mul.v4i32(<4 x i32> %bin.rdx)
  %cmp.n = icmp eq i32 %4, %n.vec
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph.preheader11

.lr.ph.preheader11:                               ; preds = %.lr.ph.preheader, %middle.block
  %.08.ph = phi i32 [ 1, %.lr.ph.preheader ], [ %19, %middle.block ]
  %.057.ph = phi i32 [ 2, %.lr.ph.preheader ], [ %ind.end, %middle.block ]
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader11, %.lr.ph
  %.08 = phi i32 [ %20, %.lr.ph ], [ %.08.ph, %.lr.ph.preheader11 ]
  %.057 = phi i32 [ %21, %.lr.ph ], [ %.057.ph, %.lr.ph.preheader11 ]
  %20 = mul nsw i32 %.08, %.057
  %21 = add nuw i32 %.057, 1
  %exitcond.not = icmp eq i32 %.057, %3
  br i1 %exitcond.not, label %._crit_edge, label %.lr.ph, !llvm.loop !11

._crit_edge:                                      ; preds = %.lr.ph, %middle.block, %0
  %.0.lcssa = phi i32 [ 1, %0 ], [ %19, %middle.block ], [ %20, %.lr.ph ]
  %22 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i32 noundef %.0.lcssa)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @__isoc99_scanf(i8* nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i32 @llvm.vector.reduce.mul.v4i32(<4 x i32>) #2

attributes #0 = { nofree nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind readnone willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!6 = distinct !{!6, !7, !8}
!7 = !{!"llvm.loop.mustprogress"}
!8 = !{!"llvm.loop.isvectorized", i32 1}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.unroll.disable"}
!11 = distinct !{!11, !7, !12, !8}
!12 = !{!"llvm.loop.unroll.runtime.disable"}
