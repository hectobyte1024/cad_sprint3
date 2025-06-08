<!-- In your available units section -->
<div class="col-12">
    <div class="unidad-card card">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <h5 class="card-title mb-1">
                        <?= htmlspecialchars($unidad['Acrónimo']) ?>
                        <span class="badge bg-<?= strpos($unidad['tipo_unidad'], 'Fuerza') !== false ? 'danger' : 'primary' ?>">
                            <?= htmlspecialchars($unidad['tipo_unidad']) ?>
                        </span>
                    </h5>
                    <p class="card-text mb-1">
                        <small class="text-muted">
                            Ubicación: <?= htmlspecialchars($unidad['latitud']) ?>, <?= htmlspecialchars($unidad['longitud']) ?>
                        </small>
                    </p>
                </div>
                <span class="badge bg-success">Disponible</span>
            </div>
            
            <form method="POST" class="mt-3">
                <input type="hidden" name="id_unidad" value="<?= $unidad['ID'] ?>">
                <div class="mb-3">
                    <label for="comentarios_<?= $unidad['ID'] ?>" class="form-label">Comentarios (opcional):</label>
                    <textarea class="form-control" id="comentarios_<?= $unidad['ID'] ?>" 
                              name="comentarios" rows="2"></textarea>
                </div>
                <button type="submit" name="asignar_unidad" class="btn btn-sm btn-<?= strpos($unidad['tipo_unidad'], 'Fuerza') !== false ? 'danger' : 'success' ?> w-100">
                    <i class="bi bi-check-circle"></i> Asignar <?= strpos($unidad['tipo_unidad'], 'Fuerza') !== false ? 'Unidad de Fuerza' : 'Unidad' ?>
                </button>
            </form>
        </div>
    </div>
</div>