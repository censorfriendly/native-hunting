SellerLocation = {
    x = -776.64,
    y = 5593.63,
    z = 33.64,
    rotation = 160.71
}
TimeToBait = 300000 --MS Time between allowed baiting
HuntingArea = vector3(-1168.54,3835.29,485.14)
HuntingRadius = 1000.0
-- Items that can be dropped, as well as items the seller will buy
ItemList = {
    [0] = {
        ["name"] = "Animal Skin",
        ["price"] = 60,
    },
    [0] = {
        ["name"] = "Raw Meat",
        ["price"] = 60,
    },
    [0] = {
        ["name"] = "Dog Skin",
        ["price"] = 60,
    },
    [0] = {
        ["name"] = "Rabbit Meat",
        ["price"] = 60,
    },
    [0] = {
        ["name"] = "Rabbit Foot",
        ["price"] = 60,
    },
    [0] = {
        ["name"] = "Hawk Foot",
        ["price"] = 60,
    },
    [0] = {
        ["name"] = "Animal Skin",
        ["price"] = 60,
    },
    [0] = {
        ["name"] = "Beefn",
        ["price"] = 60
    }
}
SellerHash = -1988720319

spawnablePeds = {
    ["common"] = {
        ["aggressive"] = {
            [307287994] = {
                ["items"] = {
                    "Animal Skin",
                    "Raw Meat"
                }
            } --mountain lion
        },
        ["nonaggressive"] = {
            [-664053099] = {
                ["items"] = {
                    "Animal Skin",
                    "Raw Meat"
                }
            } --deer
        }
    },
    ["uncommon"]= {
        ["aggressive"] = {
            [307287994] = {
                ["items"] = {
                    "Animal Skin",
                    "Raw Meat"
                }
            } --mountain lion
        },
        ["nonaggressive"] = {
            [-1323586730] = {
                ["items"] = {
                    "Animal Skin",
                    "Raw Meat"
                }
            }, --pig
            [1794449327] = {
                ["items"] = {
                    "Animal Skin",
                    "Raw Meat"
                }
            }, --hen
            [882848737] = {
                ["items"] = {
                    "Dog Skin",
                    "Raw Meat"
                }
            }, --retriever
            [1682622302] = {
                ["items"] = {
                    "Animal Skin",
                    "Raw Meat"
                }
            }--coyote
        }
    },
    ["rare"] = {
        ["aggressive"] = {
            [307287994] = {
                ["items"] = {
                    "Animal Skin",
                    "Raw Meat"
                }
            } --mountain lion
        },
        ["nonaggressive"] = {
            [-541762431] = {
                ["items"] = {
                    "Rabbit Meat",
                    "Rabbit Foot"
                }
            }, --rabbit
            [-1430839454] = {
                ["items"] = {
                    "Hawk Foot"
                }
            }, -- chicken hawk
            [-832573324] = {
                ["items"] = {
                    "Animal Skin",
                    "Raw Meat"
                }
            } --boar
        }
    },
    ["epic"] = {
        ["aggressive"] = {
            [307287994] = {
                ["items"] = {
                    "Animal Skin",
                    "Raw Meet"
                }
            } --mountain lion
        },
        ["nonaggressive"] = {
            [-50684386] = {
                ["items"] = {
                    "Animal Skin",
                    "Beef"
                }
            } -- cow
        }
    }

}