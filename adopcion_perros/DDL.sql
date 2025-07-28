BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "api_centroadopcion" (
	"id"	integer NOT NULL,
	"nombre"	varchar(100) NOT NULL,
	"direccion"	text NOT NULL,
	"telefono"	varchar(20) NOT NULL,
	"correo"	varchar(254) NOT NULL,
	"horario"	varchar(100) NOT NULL,
	"ubicacion_mapa"	varchar(200) NOT NULL,
	"logo"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "api_mascota" (
	"id"	integer NOT NULL,
	"nombre"	varchar(100) NOT NULL,
	"tipo"	varchar(10) NOT NULL,
	"raza"	varchar(100) NOT NULL,
	"edad"	integer NOT NULL,
	"tamano"	varchar(50) NOT NULL,
	"sexo"	varchar(10) NOT NULL,
	"descripcion"	text NOT NULL,
	"foto_url"	varchar(200) NOT NULL,
	"disponible"	bool NOT NULL,
	"estado_salud"	varchar(100) NOT NULL,
	"centro_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("centro_id") REFERENCES "api_centroadopcion"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "api_solicitudadopcion" (
	"id"	integer NOT NULL,
	"nombre_completo"	varchar(100) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"telefono"	varchar(20) NOT NULL,
	"mensaje"	text NOT NULL,
	"estado"	varchar(20) NOT NULL,
	"fecha_solicitud"	datetime NOT NULL,
	"mascota_id"	bigint NOT NULL,
	"usuario_id"	bigint,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("mascota_id") REFERENCES "api_mascota"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("usuario_id") REFERENCES "usuarios_usuario"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "authtoken_token" (
	"key"	varchar(40) NOT NULL,
	"created"	datetime NOT NULL,
	"user_id"	bigint NOT NULL UNIQUE,
	PRIMARY KEY("key"),
	FOREIGN KEY("user_id") REFERENCES "usuarios_usuario"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	bigint NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "usuarios_usuario"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "usuarios_usuario" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"first_name"	varchar(150) NOT NULL,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"rol"	varchar(20) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "usuarios_usuario_groups" (
	"id"	integer NOT NULL,
	"usuario_id"	bigint NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("usuario_id") REFERENCES "usuarios_usuario"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "usuarios_usuario_user_permissions" (
	"id"	integer NOT NULL,
	"usuario_id"	bigint NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("usuario_id") REFERENCES "usuarios_usuario"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "api_centroadopcion" VALUES (1,'Rescue Me Tijuana AC','Av. Revolución 1810, Zona Centro, Tijuana, B.C., C.P. 22000','+52 664 123 4567','contacto@rescueme.tj','Lun–Dom 9:00–18:00','https://maps.google.com/?q=Av.+Revolución+1810+Tijuana',NULL);
INSERT INTO "api_centroadopcion" VALUES (2,'SOLITOS EN LA CALLE A.C.','Calle Segunda 345, Zona Río, Tijuana, B.C., C.P. 22010','+52 664 765 4321','info@solitosenlacalle.ac','Lun–Vie 10:00–16:00','https://maps.google.com/?q=Calle+Segunda+345+Tijuana',NULL);
INSERT INTO "api_centroadopcion" VALUES (3,'Voluntarios TJ','Blvd. Sánchez Taboada 1500, Sánchez Taboada, Tijuana, B.C., C.P. 22120','+52 664 987 6543','hola@voluntariostj.mx','Lun–Dom 8:00–20:00','https://maps.google.com/?q=Blvd.+Sánchez+Taboada+1500+Tijuana',NULL);
INSERT INTO "api_mascota" VALUES (1,'Firulais','perro','Labrador',3,'Grande','Macho','Muy amigable','http://127.0.0.1:8000/static/adopcion_perros/img/mascotas/firulais.jpg',0,'Desconocido',1);
INSERT INTO "api_mascota" VALUES (2,'Max','perro','Pitbull',4,'Mediano','Macho','Fuerte y leal','http://127.0.0.1:8000/static/adopcion_perros/img/mascotas/max.jpg',1,'Desconocido',1);
INSERT INTO "api_mascota" VALUES (3,'Luna','perro','Golden Retriever',2,'Grande','Hembra','Cariñosa y tranquila','http://127.0.0.1:8000/static/adopcion_perros/img/mascotas/luna.jpg',1,'Desconocido',2);
INSERT INTO "api_mascota" VALUES (4,'Rocky','perro','Boxer',5,'Grande','Macho','Protector y enérgico','http://127.0.0.1:8000/static/adopcion_perros/img/mascotas/rocky.jpg',1,'Desconocido',2);
INSERT INTO "api_mascota" VALUES (5,'Toby','perro','Beagle',1,'Pequeño','Macho','Muy curioso','http://127.0.0.1:8000/static/adopcion_perros/img/mascotas/toby.jpg',1,'Desconocido',3);
INSERT INTO "api_mascota" VALUES (6,'Michi','gato','Siamés',2,'Pequeño','Hembra','Tranquila y cariñosa','http://127.0.0.1:8000/static/adopcion_perros/img/mascotas/michi.jpg',1,'Desconocido',1);
INSERT INTO "api_mascota" VALUES (7,'Pelusa','gato','Persa',3,'Pequeño','Hembra','Esponjosa y dormilona','http://127.0.0.1:8000/static/adopcion_perros/img/mascotas/pelusa.jpg',1,'Desconocido',1);
INSERT INTO "api_mascota" VALUES (8,'Nube','gato','Angora',1,'Pequeño','Hembra','Muy suave','http://127.0.0.1:8000/static/adopcion_perros/img/mascotas/nube.jpg',1,'Desconocido',2);
INSERT INTO "api_mascota" VALUES (9,'Tom','gato','Criollo',4,'Mediano','Macho','Juguetón y audaz','http://127.0.0.1:8000/static/adopcion_perros/img/mascotas/tom.jpg',1,'Desconocido',2);
INSERT INTO "api_mascota" VALUES (10,'Gato con Botas','gato','Europeo',5,'Grande','Macho','Aventurero y curioso','http://127.0.0.1:8000/static/adopcion_perros/img/mascotas/gato_con_botas.jpg',1,'Desconocido',3);
INSERT INTO "api_solicitudadopcion" VALUES (4,'Cristofer','Cristofer@gmail.com','6641155425','Me gustan los perros.','Aprobado','2025-07-27 06:47:11.863441',1,2);
INSERT INTO "api_solicitudadopcion" VALUES (5,'Cristofer','Cristofer@gmail.com','6641155425','Ya esta adoptado','Rechazado','2025-07-27 07:13:48.241625',1,2);
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (14,4,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (15,4,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (16,4,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (17,5,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (18,5,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (19,5,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (20,5,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (21,6,'add_token','Can add Token');
INSERT INTO "auth_permission" VALUES (22,6,'change_token','Can change Token');
INSERT INTO "auth_permission" VALUES (23,6,'delete_token','Can delete Token');
INSERT INTO "auth_permission" VALUES (24,6,'view_token','Can view Token');
INSERT INTO "auth_permission" VALUES (25,7,'add_tokenproxy','Can add Token');
INSERT INTO "auth_permission" VALUES (26,7,'change_tokenproxy','Can change Token');
INSERT INTO "auth_permission" VALUES (27,7,'delete_tokenproxy','Can delete Token');
INSERT INTO "auth_permission" VALUES (28,7,'view_tokenproxy','Can view Token');
INSERT INTO "auth_permission" VALUES (29,8,'add_centroadopcion','Can add centro adopcion');
INSERT INTO "auth_permission" VALUES (30,8,'change_centroadopcion','Can change centro adopcion');
INSERT INTO "auth_permission" VALUES (31,8,'delete_centroadopcion','Can delete centro adopcion');
INSERT INTO "auth_permission" VALUES (32,8,'view_centroadopcion','Can view centro adopcion');
INSERT INTO "auth_permission" VALUES (33,9,'add_mascota','Can add mascota');
INSERT INTO "auth_permission" VALUES (34,9,'change_mascota','Can change mascota');
INSERT INTO "auth_permission" VALUES (35,9,'delete_mascota','Can delete mascota');
INSERT INTO "auth_permission" VALUES (36,9,'view_mascota','Can view mascota');
INSERT INTO "auth_permission" VALUES (37,10,'add_solicitudadopcion','Can add solicitud adopcion');
INSERT INTO "auth_permission" VALUES (38,10,'change_solicitudadopcion','Can change solicitud adopcion');
INSERT INTO "auth_permission" VALUES (39,10,'delete_solicitudadopcion','Can delete solicitud adopcion');
INSERT INTO "auth_permission" VALUES (40,10,'view_solicitudadopcion','Can view solicitud adopcion');
INSERT INTO "auth_permission" VALUES (41,11,'add_favorito','Can add favorito');
INSERT INTO "auth_permission" VALUES (42,11,'change_favorito','Can change favorito');
INSERT INTO "auth_permission" VALUES (43,11,'delete_favorito','Can delete favorito');
INSERT INTO "auth_permission" VALUES (44,11,'view_favorito','Can view favorito');
INSERT INTO "auth_permission" VALUES (45,12,'add_usuario','Can add user');
INSERT INTO "auth_permission" VALUES (46,12,'change_usuario','Can change user');
INSERT INTO "auth_permission" VALUES (47,12,'delete_usuario','Can delete user');
INSERT INTO "auth_permission" VALUES (48,12,'view_usuario','Can view user');
INSERT INTO "authtoken_token" VALUES ('41b9fb5ef8b7356b9f19d0486b6c72893f75375d','2025-07-28 00:08:40.172789',2);
INSERT INTO "django_admin_log" VALUES (1,'1','Rescue Me Tijuana AC',1,'[{"added": {}}]',8,1,'2025-07-27 00:03:58.799201');
INSERT INTO "django_admin_log" VALUES (2,'2','SOLITOS EN LA CALLE A.C.',1,'[{"added": {}}]',8,1,'2025-07-27 00:05:17.048677');
INSERT INTO "django_admin_log" VALUES (3,'3','Voluntarios TJ',1,'[{"added": {}}]',8,1,'2025-07-27 00:06:03.134738');
INSERT INTO "django_admin_log" VALUES (4,'1','Firulais (perro)',1,'[{"added": {}}]',9,1,'2025-07-27 01:58:32.690785');
INSERT INTO "django_admin_log" VALUES (5,'1','Firulais (perro)',3,'',9,1,'2025-07-27 02:08:44.196445');
INSERT INTO "django_admin_log" VALUES (6,'10','Gato con Botas (gato)',2,'[]',9,1,'2025-07-27 03:50:05.054048');
INSERT INTO "django_admin_log" VALUES (7,'1','Firulais (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 04:30:38.951038');
INSERT INTO "django_admin_log" VALUES (8,'10','Gato con Botas (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 04:31:41.310738');
INSERT INTO "django_admin_log" VALUES (9,'3','Luna (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 04:32:15.781293');
INSERT INTO "django_admin_log" VALUES (10,'2','Max (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 04:32:44.982853');
INSERT INTO "django_admin_log" VALUES (11,'6','Michi (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 04:33:13.876404');
INSERT INTO "django_admin_log" VALUES (12,'10','Gato con Botas (gato)',2,'[]',9,1,'2025-07-27 04:33:20.211493');
INSERT INTO "django_admin_log" VALUES (13,'8','Nube (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 04:33:45.001446');
INSERT INTO "django_admin_log" VALUES (14,'7','Pelusa (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 04:34:16.989705');
INSERT INTO "django_admin_log" VALUES (15,'4','Rocky (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 04:34:51.257861');
INSERT INTO "django_admin_log" VALUES (16,'5','Toby (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 04:35:18.749975');
INSERT INTO "django_admin_log" VALUES (17,'9','Tom (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 04:35:42.526294');
INSERT INTO "django_admin_log" VALUES (18,'1','Manuel - Firulais',2,'[{"changed": {"fields": ["Estado"]}}]',10,1,'2025-07-27 06:27:13.395930');
INSERT INTO "django_admin_log" VALUES (19,'3','Messi - Rocky',3,'',10,1,'2025-07-27 06:46:18.990121');
INSERT INTO "django_admin_log" VALUES (20,'2','Cristofer - Firulais',3,'',10,1,'2025-07-27 06:46:18.990182');
INSERT INTO "django_admin_log" VALUES (21,'1','Manuel - Firulais',3,'',10,1,'2025-07-27 06:46:18.990204');
INSERT INTO "django_admin_log" VALUES (22,'10','Gato con Botas (gato)',2,'[]',9,1,'2025-07-27 06:52:31.523134');
INSERT INTO "django_admin_log" VALUES (23,'10','Gato con Botas (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 07:08:49.222869');
INSERT INTO "django_admin_log" VALUES (24,'9','Tom (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 07:09:02.901518');
INSERT INTO "django_admin_log" VALUES (25,'8','Nube (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 07:09:10.875604');
INSERT INTO "django_admin_log" VALUES (26,'7','Pelusa (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 07:09:18.963292');
INSERT INTO "django_admin_log" VALUES (27,'7','Pelusa (gato)',2,'[]',9,1,'2025-07-27 07:09:23.636653');
INSERT INTO "django_admin_log" VALUES (28,'6','Michi (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 07:09:30.590228');
INSERT INTO "django_admin_log" VALUES (29,'5','Toby (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 07:09:39.473316');
INSERT INTO "django_admin_log" VALUES (30,'4','Rocky (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 07:09:46.603807');
INSERT INTO "django_admin_log" VALUES (31,'3','Luna (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 07:09:53.535441');
INSERT INTO "django_admin_log" VALUES (32,'3','Luna (perro)',2,'[]',9,1,'2025-07-27 07:09:58.824197');
INSERT INTO "django_admin_log" VALUES (33,'2','Max (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 07:10:05.298893');
INSERT INTO "django_admin_log" VALUES (34,'1','Firulais (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 07:10:11.161229');
INSERT INTO "django_admin_log" VALUES (35,'1','Firulais (perro)',2,'[{"changed": {"fields": ["Disponible"]}}]',9,1,'2025-07-27 07:14:25.924900');
INSERT INTO "django_admin_log" VALUES (36,'10','Gato con Botas (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 22:55:35.829909');
INSERT INTO "django_admin_log" VALUES (37,'9','Tom (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 22:55:44.529691');
INSERT INTO "django_admin_log" VALUES (38,'8','Nube (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 22:55:51.981785');
INSERT INTO "django_admin_log" VALUES (39,'7','Pelusa (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 22:55:59.414918');
INSERT INTO "django_admin_log" VALUES (40,'6','Michi (gato)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 22:56:08.008949');
INSERT INTO "django_admin_log" VALUES (41,'5','Toby (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 22:56:17.714436');
INSERT INTO "django_admin_log" VALUES (42,'4','Rocky (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 22:56:25.998616');
INSERT INTO "django_admin_log" VALUES (43,'3','Luna (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 22:56:32.214429');
INSERT INTO "django_admin_log" VALUES (44,'2','Max (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 22:56:39.659237');
INSERT INTO "django_admin_log" VALUES (45,'2','Max (perro)',2,'[]',9,1,'2025-07-27 22:56:44.084996');
INSERT INTO "django_admin_log" VALUES (46,'1','Firulais (perro)',2,'[{"changed": {"fields": ["Foto url"]}}]',9,1,'2025-07-27 22:56:52.543761');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (5,'sessions','session');
INSERT INTO "django_content_type" VALUES (6,'authtoken','token');
INSERT INTO "django_content_type" VALUES (7,'authtoken','tokenproxy');
INSERT INTO "django_content_type" VALUES (8,'api','centroadopcion');
INSERT INTO "django_content_type" VALUES (9,'api','mascota');
INSERT INTO "django_content_type" VALUES (10,'api','solicitudadopcion');
INSERT INTO "django_content_type" VALUES (11,'api','favorito');
INSERT INTO "django_content_type" VALUES (12,'usuarios','usuario');
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2025-07-26 23:47:59.663813');
INSERT INTO "django_migrations" VALUES (2,'contenttypes','0002_remove_content_type_name','2025-07-26 23:47:59.686495');
INSERT INTO "django_migrations" VALUES (3,'auth','0001_initial','2025-07-26 23:47:59.721474');
INSERT INTO "django_migrations" VALUES (4,'auth','0002_alter_permission_name_max_length','2025-07-26 23:47:59.751941');
INSERT INTO "django_migrations" VALUES (5,'auth','0003_alter_user_email_max_length','2025-07-26 23:47:59.766092');
INSERT INTO "django_migrations" VALUES (6,'auth','0004_alter_user_username_opts','2025-07-26 23:47:59.785199');
INSERT INTO "django_migrations" VALUES (7,'auth','0005_alter_user_last_login_null','2025-07-26 23:47:59.804987');
INSERT INTO "django_migrations" VALUES (8,'auth','0006_require_contenttypes_0002','2025-07-26 23:47:59.820363');
INSERT INTO "django_migrations" VALUES (9,'auth','0007_alter_validators_add_error_messages','2025-07-26 23:47:59.837176');
INSERT INTO "django_migrations" VALUES (10,'auth','0008_alter_user_username_max_length','2025-07-26 23:47:59.858207');
INSERT INTO "django_migrations" VALUES (11,'auth','0009_alter_user_last_name_max_length','2025-07-26 23:47:59.876365');
INSERT INTO "django_migrations" VALUES (12,'auth','0010_alter_group_name_max_length','2025-07-26 23:47:59.905140');
INSERT INTO "django_migrations" VALUES (13,'auth','0011_update_proxy_permissions','2025-07-26 23:47:59.922619');
INSERT INTO "django_migrations" VALUES (14,'auth','0012_alter_user_first_name_max_length','2025-07-26 23:47:59.949297');
INSERT INTO "django_migrations" VALUES (15,'usuarios','0001_initial','2025-07-26 23:47:59.994352');
INSERT INTO "django_migrations" VALUES (16,'admin','0001_initial','2025-07-26 23:48:00.031483');
INSERT INTO "django_migrations" VALUES (17,'admin','0002_logentry_remove_auto_add','2025-07-26 23:48:00.067799');
INSERT INTO "django_migrations" VALUES (18,'admin','0003_logentry_add_action_flag_choices','2025-07-26 23:48:00.083629');
INSERT INTO "django_migrations" VALUES (19,'api','0001_initial','2025-07-26 23:48:00.138180');
INSERT INTO "django_migrations" VALUES (20,'authtoken','0001_initial','2025-07-26 23:48:00.166983');
INSERT INTO "django_migrations" VALUES (21,'authtoken','0002_auto_20160226_1747','2025-07-26 23:48:00.202097');
INSERT INTO "django_migrations" VALUES (22,'authtoken','0003_tokenproxy','2025-07-26 23:48:00.220335');
INSERT INTO "django_migrations" VALUES (23,'authtoken','0004_alter_tokenproxy_options','2025-07-26 23:48:00.236826');
INSERT INTO "django_migrations" VALUES (24,'sessions','0001_initial','2025-07-26 23:48:00.266315');
INSERT INTO "django_migrations" VALUES (25,'api','0002_centroadopcion_logo','2025-07-27 01:06:27.470263');
INSERT INTO "django_session" VALUES ('s34birj3z19oz7vucskz0h520qdzg4tp','.eJxVjDsOwyAQRO9CHSHzM5Ayvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72tZaohM9uIJMNKIyj3sNqUCC9BCcGP5KzYLPWHmNGktaJnLzxmgCBfb7X0zgQ:1ufvDN:3AsZTPdWVXp7W37-SxBcccN-WYJ1bupRtLtf5XHtMFQ','2025-08-10 06:50:33.430790');
INSERT INTO "django_session" VALUES ('a003pbbusvzfjy00cc9ghhhnw7q7p3wh','.eJxVjEEOwiAQRe_C2hDBAYpL9z0DGQZGqgaS0q6Md7dNutDte-__twi4LiWsPc9hSuIqlDj9soj0zHUX6YH13iS1usxTlHsiD9vl2FJ-3Y7276BgL9vaIYBV2RFzit57o7QxFiNTMoOO1rJPGyYbz36g7Jx3CtjSBVADM4jPF-xXOAc:1ugBkO:YylnBVpH3G9SRw9_GwB5nFOC2Be4xizo1txp64_ELDw','2025-08-11 00:29:44.022422');
INSERT INTO "usuarios_usuario" VALUES (1,'pbkdf2_sha256$870000$z7uBc0NGYkrkzwv9POJ6Yf$ICXeWLH1WDtyRDkG+brgFMvTQNmqnWfJnvzupP1lq6U=','2025-07-28 00:29:44.001939',1,'admin','','','admin@correo.com',1,1,'2025-07-26 23:52:48.256224','adoptante');
INSERT INTO "usuarios_usuario" VALUES (2,'pbkdf2_sha256$870000$O2jMVTwuFZigT8hIltMsjD$h1DTu8348ypkrlz8HifwiIcGOXibRza6v/i7ENco2yg=','2025-07-27 06:50:33.414838',0,'Cristofer','','','Cristofer@gmail.com',0,1,'2025-07-27 00:10:37.573255','adoptante');
INSERT INTO "usuarios_usuario" VALUES (3,'pbkdf2_sha256$870000$oTP0KFb6TTOBqXMuXtWDvP$IsApdXOWSSLVIPE/bx2vJfqxqzUI446+WuV5JTcMcv4=',NULL,0,'Luis','','','Luis@gmail.com',0,1,'2025-07-27 04:50:05.603866','adoptante');
INSERT INTO "usuarios_usuario" VALUES (4,'pbkdf2_sha256$870000$qbWvt4ojQD7l6xa9B1vx6K$zB/o3p84w7h0PsCjhY+RngupOFedz0+vC4IRC7z5Tic=','2025-07-27 06:45:27.363449',0,'Manuel','','','Manuel@gmail.com',0,1,'2025-07-27 04:55:54.842522','adoptante');
CREATE INDEX IF NOT EXISTS "api_mascota_centro_id_cbdeb014" ON "api_mascota" (
	"centro_id"
);
CREATE INDEX IF NOT EXISTS "api_solicitudadopcion_mascota_id_e3fffca2" ON "api_solicitudadopcion" (
	"mascota_id"
);
CREATE INDEX IF NOT EXISTS "api_solicitudadopcion_usuario_id_4813920a" ON "api_solicitudadopcion" (
	"usuario_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "usuarios_usuario_groups_group_id_e77f6dcf" ON "usuarios_usuario_groups" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "usuarios_usuario_groups_usuario_id_7a34077f" ON "usuarios_usuario_groups" (
	"usuario_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "usuarios_usuario_groups_usuario_id_group_id_4ed5b09e_uniq" ON "usuarios_usuario_groups" (
	"usuario_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "usuarios_usuario_user_permissions_permission_id_4e5c0f2f" ON "usuarios_usuario_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "usuarios_usuario_user_permissions_usuario_id_60aeea80" ON "usuarios_usuario_user_permissions" (
	"usuario_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "usuarios_usuario_user_permissions_usuario_id_permission_id_217cadcd_uniq" ON "usuarios_usuario_user_permissions" (
	"usuario_id",
	"permission_id"
);
COMMIT;
