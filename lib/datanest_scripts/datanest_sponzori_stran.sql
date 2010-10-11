ALTER TABLE datanest_sponzori_stran CHANGE COLUMN `_record_id` `id` VARCHAR(500),
 MODIFY COLUMN `ico_darcu` integer,
 MODIFY COLUMN `hodnota_daru` float,
 MODIFY COLUMN `rok` integer;

UPDATE datanest_sponzori_stran SET
  hodnota_daru = hodnota_daru / 30.126,
  mena = 'EUR'
 WHERE mena = 'Sk';
