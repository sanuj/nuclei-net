# nuclei-net
Code related to my Bachelor's Thesis Project

  - Put `caffe-scripts/nuclei` in `CAFFE_ROOT/examples/nuclei` to make the scripts work
    - `caffe-scripts/nuclei` contains:
      - `multi_class_nuclei`: this was trained on data of 10 classes from different whole slide images.
      - `multi_class_nuclei/use_multi_class`: Model from multi_class_nuclei was finetuned for the nucleus binary classification.
      - `train_cifar`: the model was trained on cifar-10 data and then fintuned on nuclei data.
    - `caffe-scripts/predict.py`: used to predict labels by using a trained model. Put this in your CAFFE_ROOT.
  - `data` contains images and scripts for preparing data for both Caffe and Theano.
