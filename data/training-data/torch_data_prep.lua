require 'io'
require 'torch'
require 'image'

file_name = '/home/sanuj/Projects/nuclei-net/data/training-data/63_LLM_YR4_3_class_31/test_small.txt'
-- file_name = '/home/sanuj/Projects/nuclei-net/data/training-data/78_RLM_YR4_3_class_31/train_small.txt'
num_images = 15000
num_channels = 3
width = 31
height = 31

file = io.open(file_name, 'rb')
data = torch.Tensor(num_images, num_channels, width, height):byte()
label = torch.Tensor(num_images):byte()
counter = 1

for line in file:lines() do
	print(counter)
	image_name, image_label = line:split(' ')[1], line:split(' ')[2]
	data[counter] = image.load(image_name, num_channels, 'byte')
	label[counter] = image_label
	counter = counter + 1
end

torch.save('/home/sanuj/Projects/nuclei-net/data/training-data/63_LLM_YR4_3_class_31/test_small.t7', {data = data, label = label})
-- torch.save('/home/sanuj/Projects/nuclei-net/data/training-data/78_RLM_YR4_3_class_31/train_small.t7', {data = data, label = label})
