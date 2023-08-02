from torch.utils.data import Dataset
from pathlib import Path
import numpy as np
from PIL import Image

class Cifar10_1(Dataset):
    def __init__(self, root, transform=None):
        self.data, self.targets = self.load_data(root)
        self.transform = transform
        
    def __getitem__(self, index):
        x = self.data[index]
        y = self.targets[index]
        
        if self.transform:
            x = Image.fromarray(x)
            x = self.transform(x)
        
        return x, y
    
    def __len__(self):
        return len(self.data)

    def load_data(self, path):
        # check path
        path = Path(path).expanduser()
        assert path.exists(), f"dataset cifar10.1: directory {path} does not exist"

        filename = 'cifar10.1_v6'
        label_filename = filename + '_labels.npy'
        data_filename  = filename + '_data.npy'
        label_path = path/label_filename
        data_path = path/data_filename

        assert label_path.is_file()
        assert data_path.is_file()

        labels = np.load(label_path)
        data = np.load(data_path)

        assert len(labels.shape) == 1
        assert len(data.shape) == 4
        assert labels.shape[0] == data.shape[0]
        assert data.shape[1] == 32
        assert data.shape[2] == 32
        assert data.shape[3] == 3

        assert labels.shape[0] == 2000

        return data, labels
    