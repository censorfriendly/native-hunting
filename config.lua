Config = {}
Config.SellerLocation = {
    x = -776.64,
    y = 5593.63,
    z = 33.64,
    rotation = 160.71
}
Config.TimeToBait = 300000 --MS Time between allowed baiting
Config.HuntingArea = vector3(-1168.54,3835.29,485.14)
Config.HuntingRadius = 1000.0
Config.HuntingWeaponHash = -1625947810
Config.BaitHash = -1663028984
Config.SellerHash = -1988720319
-- Items that can be dropped, as well as items the seller will buy
Config.Shop = {
    ["label"] = "Hunting Lodge",
    ["items"] = {
        [1] = {
            name = "bait",
            price = 200,
            amount = 50,
            info = {},
            type = "item",
            slot = 1
            },
        [2] = {
                name = "hunting_knife",
                price = 10000,
                amount = 1,
                info = {},
                type = "item",
                slot = 2
            },
        [3] = {
                name = "weapon_hunting_rifle",
                price = 20000,
                amount = 1,
                info = {},
                type = "weapon",
                slot = 3
            }
        }
}
Config.ItemList = {
    [1] = {
        ["label"] ="Hide",
        ["name"] = "hide",
        ["price"] = 50
    },
    [2] = {
        ["label"] ="Raw Meat",
        ["name"] = "rawmeat",
        ["price"] = 50
    },
    [3] = {
        ["label"] ="Dog Skin",
        ["name"] = "dog_skin",
        ["price"] = 50
    },
    [4] = {
        ["label"] ="Rabbit Meat",
        ["name"] = "rabbit_meat",
        ["price"] = 50
    },
    [5] = {
        ["label"] ="Rabbit Foot",
        ["name"] = "rabbit_foot",
        ["price"] = 50
    },
    [6] = {
        ["label"] ="Hawk Claw",
        ["name"] = "hawk_claw",
        ["price"] = 50
    },
    [7] = {
        ["label"] ="Hide",
        ["name"] = "hide",
        ["price"] = 50
    },
    [8] = {
        ["label"] ="Beef",
        ["name"] = "beef",
        ["price"] = 50
    }
}

Config.spawnablePeds = {
    ["common"] = {
        ["aggressive"] = {
            [307287994] = {
                ["items"] = {
                    "hide",
                    "rawmeat"
                }
            } --mountain lion
        },
        ["nonaggressive"] = {
            [-664053099] = {
                ["items"] = {
                    "hide",
                    "rawmeat"
                }
            } --deer
        }
    },
    ["uncommon"]= {
        ["aggressive"] = {
            [307287994] = {
                ["items"] = {
                    "hide",
                    "rawmeat"
                }
            } --mountain lion
        },
        ["nonaggressive"] = {
            [1794449327] = {
                ["items"] = {
                    "hide",
                    "rawmeat"
                }
            }, --hen
            [882848737] = {
                ["items"] = {
                    "dog_skin",
                    "rawmeat"
                }
            }, --retriever
            [1682622302] = {
                ["items"] = {
                    "hide",
                    "rawmeat"
                }
            },--coyote
            [-541762431] = {
                ["items"] = {
                    "rabbit_meat",
                    "rabbit_foot"
                }
            }, --rabbit
            [-1430839454] = {
                ["items"] = {
                    "hawk_claw"
                }
            } -- chicken hawk
        }
    },
    ["rare"] = {
        ["aggressive"] = {
            [307287994] = {
                ["items"] = {
                    "hide",
                    "rawmeat"
                }
            } --mountain lion
        },
        ["nonaggressive"] = {
            [-1323586730] = {
                ["items"] = {
                    "hide",
                    "rawmeat"
                }
            }, --pig
            [-832573324] = {
                ["items"] = {
                    "hide",
                    "rawmeat"
                }
            } --boar
        }
    },
    ["epic"] = {
        ["aggressive"] = {
            [307287994] = {
                ["items"] = {
                    "hide",
                    "rawmeat"
                }
            } --mountain lion
        },
        ["nonaggressive"] = {
            [-50684386] = {
                ["items"] = {
                    "hide",
                    "beef"
                }
            } -- cow
        }
    }

}