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
  %5 = add i32 %3, -2
  %xtraiter = and i32 %4, 7
  %6 = icmp ult i32 %5, 7
  br i1 %6, label %._crit_edge.loopexit.unr-lcssa, label %.lr.ph.preheader.new

.lr.ph.preheader.new:                             ; preds = %.lr.ph.preheader
  %unroll_iter = and i32 %4, -8
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %.lr.ph.preheader.new
  %.08 = phi i32 [ 1, %.lr.ph.preheader.new ], [ %21, %.lr.ph ]
  %.057 = phi i32 [ 2, %.lr.ph.preheader.new ], [ %22, %.lr.ph ]
  %niter = phi i32 [ 0, %.lr.ph.preheader.new ], [ %niter.next.7, %.lr.ph ]
  %7 = mul nsw i32 %.08, %.057
  %8 = or i32 %.057, 1
  %9 = mul nsw i32 %7, %8
  %10 = add nuw nsw i32 %.057, 2
  %11 = mul nsw i32 %9, %10
  %12 = add nuw nsw i32 %.057, 3
  %13 = mul nsw i32 %11, %12
  %14 = add nuw nsw i32 %.057, 4
  %15 = mul nsw i32 %13, %14
  %16 = add nuw nsw i32 %.057, 5
  %17 = mul nsw i32 %15, %16
  %18 = add nuw i32 %.057, 6
  %19 = mul nsw i32 %17, %18
  %20 = add nuw i32 %.057, 7
  %21 = mul nsw i32 %19, %20
  %22 = add nuw i32 %.057, 8
  %niter.next.7 = add i32 %niter, 8
  %niter.ncmp.7 = icmp eq i32 %niter.next.7, %unroll_iter
  br i1 %niter.ncmp.7, label %._crit_edge.loopexit.unr-lcssa, label %.lr.ph, !llvm.loop !6

._crit_edge.loopexit.unr-lcssa:                   ; preds = %.lr.ph, %.lr.ph.preheader
  %.lcssa.ph = phi i32 [ undef, %.lr.ph.preheader ], [ %21, %.lr.ph ]
  %.08.unr = phi i32 [ 1, %.lr.ph.preheader ], [ %21, %.lr.ph ]
  %.057.unr = phi i32 [ 2, %.lr.ph.preheader ], [ %22, %.lr.ph ]
  %lcmp.mod.not = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod.not, label %._crit_edge, label %.lr.ph.epil

.lr.ph.epil:                                      ; preds = %._crit_edge.loopexit.unr-lcssa, %.lr.ph.epil
  %.08.epil = phi i32 [ %23, %.lr.ph.epil ], [ %.08.unr, %._crit_edge.loopexit.unr-lcssa ]
  %.057.epil = phi i32 [ %24, %.lr.ph.epil ], [ %.057.unr, %._crit_edge.loopexit.unr-lcssa ]
  %epil.iter = phi i32 [ %epil.iter.next, %.lr.ph.epil ], [ 0, %._crit_edge.loopexit.unr-lcssa ]
  %23 = mul nsw i32 %.08.epil, %.057.epil
  %24 = add nuw i32 %.057.epil, 1
  %epil.iter.next = add i32 %epil.iter, 1
  %epil.iter.cmp.not = icmp eq i32 %epil.iter.next, %xtraiter
  br i1 %epil.iter.cmp.not, label %._crit_edge, label %.lr.ph.epil, !llvm.loop !8

._crit_edge:                                      ; preds = %._crit_edge.loopexit.unr-lcssa, %.lr.ph.epil, %0
  %.0.lcssa = phi i32 [ 1, %0 ], [ %.lcssa.ph, %._crit_edge.loopexit.unr-lcssa ], [ %23, %.lr.ph.epil ]
  %25 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i32 noundef %.0.lcssa)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @__isoc99_scanf(i8* nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #1

attributes #0 = { nofree nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.unroll.disable"}
