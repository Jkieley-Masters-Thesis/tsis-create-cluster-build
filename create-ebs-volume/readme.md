# Purpose Create a Kubernetes Volume mount 
Purpose Create a Kubernetes Volume mount that can be mounted with the job's prerequisits, instead of having to ssh into a working node evertime
- https://kubernetes.io/docs/concepts/storage/volumes/#awselasticblockstore
```
aws ec2 create-volume --availability-zone=us-west-2a --size=2 --volume-type=gp2
```

#error message
```
AttachVolume.Attach failed for volume "test-volume" : error attaching EBS volume "vol-0724beb76b74d22c8" to instance "i-0a399cba85a373837": "UnauthorizedOperation: You are not au
thorized to perform this operation. Encoded authorization failure message: -_CIhbva4PTgBARzHg9Z3Y1g2aTc3ArmYgS27owtDfcIiR9SLT6hbZoQ-8spsK0TYPn4chW_SaPcHrTY29LDRmScW4LN5SakbmHOxJs97GLrngOGplrSR0FhWBObOS0mEl_qvAIwB4yuTQYtA6KAi_RrlY_4fS1hFzLVavAEWsJRRm_xALud0vuuVaNfDqIMM6D
Uuk5mp4UXL2p7oRNjROp1XA1ISm6xzK5xfu6RhgN1_HaTlUqpYsapqumeXM2hX_tf0RS5gR5s6fhMKEk2JptpyyJqYZApU5yPcozbK-0k3Ltvms3sT9gdUq5sTvVABJiTVJ1c1HqX3m3xoSbKKvp2GnAkL0s6hAq3kRrPU-3FXP6rR-xL5RSqbSKDUgfNv-kfpAXkrZHYVnPKKCOV85Y7kePKOlqNXoBphlFRBJJKybVjUTlESlyCzW3ETn42fiYqL0-zJIss0fxUy
ZpbrxwPqER6bxhI0i-7aa-zIKpukTItPBZZFyo9-Jh1D8vHfrytooArFjfennCOxUAY6EcVhd2B56SRCAyRFNFnDmW1kXdIJeX77a56D8gTE9gS_4Jg8XcVrFxJOXeb3zs6KoSULleJaclWVoWFPkxBrU8GSknaGthw4P7jcEo7p2aqPjQojMjRM7d0uyFjwuo1d5yPH9F_Jk_x\n\tstatus code: 403, request id: b6f306ae-4c86-48aa-a078-6fe7
```
## solution 
- https://stackoverflow.com/questions/47278433/need-help-on-volume-mount-issue-with-kubernetes
- need to add tag to volume for kops to allow it
- ssh into worknode
- list volumes attached 
```
lsblk
```

#final conclusions
- unmounting a awsElasticBlockStore requires a forced pod deletion, otherwise strange storage issues arrise like kubernetes being unable to schedule to that pod.
- can only be mounted to a single pod at a time. 