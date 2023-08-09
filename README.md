# StudyGroup_Lab3_Q1 AlexNet

## Link

[https://github.com/YuZhong-Chen/StudyGroup_Lab3/tree/main](https://github.com/YuZhong-Chen/StudyGroup_Lab3/tree/main)

## Notice

- If you want to git clone this repo, remember to install git lfs and use ``git lfs pull`` after you clone it.
- Please run the code with "VScode-devcontainer".

## Model

```
==========================================================================================
Layer (type:depth-idx)                   Output Shape              Param #
==========================================================================================
AlexNet                                  [1, 10]                   --
├─Sequential: 1-1                        [1, 256, 3, 3]            --
│    └─Conv2d: 2-1                       [1, 64, 34, 34]           1,792
│    └─ReLU: 2-2                         [1, 64, 34, 34]           --
│    └─MaxPool2d: 2-3                    [1, 64, 16, 16]           --
│    └─Conv2d: 2-4                       [1, 192, 16, 16]          307,392
│    └─ReLU: 2-5                         [1, 192, 16, 16]          --
│    └─MaxPool2d: 2-6                    [1, 192, 7, 7]            --
│    └─Conv2d: 2-7                       [1, 384, 7, 7]            663,936
│    └─ReLU: 2-8                         [1, 384, 7, 7]            --
│    └─Conv2d: 2-9                       [1, 256, 7, 7]            884,992
│    └─ReLU: 2-10                        [1, 256, 7, 7]            --
│    └─Conv2d: 2-11                      [1, 256, 7, 7]            590,080
│    └─ReLU: 2-12                        [1, 256, 7, 7]            --
│    └─MaxPool2d: 2-13                   [1, 256, 3, 3]            --
├─AdaptiveAvgPool2d: 1-2                 [1, 256, 6, 6]            --
├─Sequential: 1-3                        [1, 10]                   --
│    └─Dropout: 2-14                     [1, 9216]                 --
│    └─Linear: 2-15                      [1, 4096]                 37,752,832
│    └─ReLU: 2-16                        [1, 4096]                 --
│    └─Dropout: 2-17                     [1, 4096]                 --
│    └─Linear: 2-18                      [1, 4096]                 16,781,312
│    └─ReLU: 2-19                        [1, 4096]                 --
│    └─Linear: 2-20                      [1, 10]                   40,970
==========================================================================================
Total params: 57,023,306
Trainable params: 57,023,306
Non-trainable params: 0
Total mult-adds (M): 240.15
==========================================================================================
Input size (MB): 0.01
Forward/backward pass size (MB): 1.40
Params size (MB): 228.09
Estimated Total Size (MB): 229.51
==========================================================================================
```

## Results 

Accuracy
- CIFAR-10 : 80.05 %
- CIFAR-10_1 : 68.45 %
