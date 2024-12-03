import coreController from "./coreController.js";
import cleanCoreData from "../../helpers/JSONcleaner/coreCleaner.js"


async function getAllCores(req, res) {
    try {
        const cores = await coreController.getAllCores();
        const cleanedCore = cleanCoreData(cores);

        res.json(cleanedCore);

    } catch (error) {
        error.status ? res.status(error.status) : res.status(500);
        res.json({ error: error.message });
    }
}

async function getCoreById(req, res) {
    try {
        const core = await coreController.getCoreById(req.params.id);
        const cleanedCore = cleanCoreData(core);

        res.json(cleanedCore);
    } catch (error) {
        error.status ? res.status(error.status) : res.status(500);
        res.json({ error: error.message });
    }
}

async function deleteCore(req, res) {
    try {
        const deletedCore = await coreController.deleteCore(req.params.id);
        res.json(deletedCore);
    } catch (error) {
        error.status? res.status(error.status) : res.status(500);
        res.json({ error: error.message });
    }
}

async function updateCore(req, res) {
    try {
        const id = parseInt(req.params.id);
        const updatedCore = req.body;

        const core = await coreController.updateCore(id, updatedCore);
        res.json(core);
    } catch (error) {
        error.status? res.status(error.status) : res.status(500);
        res.json({ error: error.message });
    }
}

export const functions = {
    getAllCores,
    getCoreById,
    deleteCore,
    updateCore,
};

export default functions;

