for part in (1, 2):
    result = 0
    with open("input/09.txt", "r") as f:
        for line in f:
            numbers = [int(x) for x in line.split()] if part == 1 else [int(x) for x in line.split()][::-1]
            layers = []
            layers.append(numbers) # first layer
            i = 0
            while not all(x == 0 for x in layers[i]):
                next_layer = []
                for j in range(len(layers[i])-1):
                    next_layer.append(layers[i][j+1] - layers[i][j])
                layers.append(next_layer)
                i += 1

            to_add = 0
            for i in range(len(layers)-1):
                to_add = layers[-(i+1)][-1]
                layers[-(i+2)].append(layers[-(i+2)][-1]+to_add)
            
            result += layers[0][-1]
        
    print(f"Answer for part {part} is:", result)