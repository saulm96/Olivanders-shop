import woodController from "./woodController.js";
import cleanWoodData from "../../helpers/JSONcleaner/woodCleaner.js"

async function getAllWoods(req, res) {
    try {
        const woods = await woodController.getAllWoods(req.user.language_id);
        const cleanedWood = cleanWoodData(woods);
        res.json(cleanedWood);

    } catch (error) {
        error.status ? res.status(error.status) : res.status(500);
        res.json({ error: error.message });
    }
}


async function getWoodById(req, res) {
    try {
        const wood = await woodController.getWoodById(req.params.id, req.user.language_id);
        const cleanedWood = cleanWoodData(wood);

        res.json(cleanedWood);
    } catch (error) {
        error.status ? res.status(error.status) : res.status(500);
        res.json({ error: error.message });
    }
}
async function deleteWood(req, res) {
    try {
        const deletedWood = await woodController.deleteWood(req.params.id);
        res.json(deletedWood);
    } catch (error) {
        error.status? res.status(error.status) : res.status(500);
        res.json({ error: error.message });
    }
}
async function updateWood(req, res) {
    try {
        const id = parseInt(req.params.id);
        const updatedWood = req.body;

        const wood = await woodController.updateWood(id, updatedWood);
        res.json(wood);
    } catch (error) {
        error.status? res.status(error.status) : res.status(500);
        res.json({ error: error.message });
    }
}

async function createWood(req, res) {
    try {
        const newWoodData = req.body;
        const wood = await woodController.createWood(newWoodData);
        res.json(wood);
    } catch (error) {
        error.status? res.status(error.status) : res.status(500);
        res.json({ error: error.message });
    }
}


export const functions = {
    getAllWoods,
    getWoodById,
    deleteWood,
    updateWood,
    createWood,
};

export default functions;