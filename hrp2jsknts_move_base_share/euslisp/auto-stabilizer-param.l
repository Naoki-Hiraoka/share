(require "package://hrpsys_ros_bridge_tutorials/euslisp/hrp2jsknts-interface.l")
(unless (boundp '*hrp2jsknts*)
  (hrp2jsknts-init)
  (setq *robot* *hrp2jsknts*)
  )

(defun start-footguided-modification
    ()
  (let* ((step-time 1.0)
         (double-ratio 0.2)
         (foot-inside 0.062)
         (dcm-offset 0.02)
         (min-time 1.0)
         (max-time 2.0)
         (max-stride-x 0.25)
         (max-stride-y 0.35)
         (margin-time-ratio 0.3))
    (send *ri* :set-gait-generator-param
          :leg-margin (float-vector 0.13 0.095 0.062 foot-inside)
          :safe-leg-margin #f(0.06 0.05 0.062 0.05)
          :dcm-offset dcm-offset
          )
  (send *ri* :set-gait-generator-param
        :stride-limitation-for-circle-type (float-vector 0.15 0.3 10 0.1 (- 0.2 foot-inside))
        :overwritable-stride-limitation    (float-vector max-stride-x max-stride-y 0 max-stride-x (- 0.19 foot-inside))
        :margin-time-ratio margin-time-ratio
        :min-time-mgn 0.3
        :use-disturbance-compensation nil
        :dc-gain 1e-3
        :swing-trajectory-delay-time-offset (* step-time (- 1.0 double-ratio) 0.3)
        :modify-footsteps t
        :use-act-states t
        :stride-limitation-type 1
        :default-orbit-type :rectangle
        :default-step-time step-time
        :min-time min-time
        :overwritable-max-time max-time
        :default-double-support-ratio double-ratio
        ;; :use-flywheel-balance t
        ;; :is-stable-go-stop-mode t
        )
  ))

(defun manip-pose
    ()
  (send *robot* :reset-manip-pose)
  (send *robot* :arms :move-end-pos #f(50 0 0))
  (send *robot* :legs :move-end-pos #f(0 0 20))
  (send *ri* :angle-vector (send *robot* :angle-vector) 5000)
  )
