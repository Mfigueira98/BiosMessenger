use master
go

--Determina si esta la base de datos 
if exists(Select * FROM SysDataBases WHERE name='BiosMessenger')
BEGIN
    DROP DATABASE BiosMessenger
END
go

CREATE DATABASE BiosMessenger
go

USE BiosMessenger
go


USE master
GO

CREATE LOGIN [IIS APPPOOL\DefaultAppPool] FROM WINDOWS 
GO

USE BiosMessenger
GO

CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool]
GO

GRANT Execute to [IIS APPPOOL\DefaultAppPool]
go



Create Table Usuarios(
    NomUsu VARCHAR(20) PRIMARY KEY CHECK(len(NomUsu)>=8),
    ContraUsu VARCHAR(8) NOT NULL CHECK (
        ContraUsu LIKE '%[a-zA-Z]%[a-zA-Z]%[a-zA-Z]%' AND
        ContraUsu LIKE '%[0-9]%[0-9]%[0-9]%' And
        ContraUsu LIKE '%[^a-zA-Z0-9]%[^a-zA-Z0-9]%'),
    NomComUsu VARCHAR(50) NOT NULL,
    FechaNacUsu DATE NOT NULL check (FechaNacUsu < Getdate()),
    EmailUsu VARCHAR(100) NOT NULL CHECK (EmailUsu LIKE '%@%._%'),
	UsuarioActivo bit not null default(1)

)
GO

CREATE TABLE Mensajes (
    IdMensaje INT not null IDENTITY PRIMARY KEY,
    FechaHoraEnvio DATETIME NOT NULL DEFAULT GETDATE(),
    Asunto VARCHAR(100) NOT NULL,
    Texto VARCHAR (1000) NOT NULL,
    UsuarioEmisor VARCHAR(20) NOT NULL,
    FOREIGN KEY (UsuarioEmisor) REFERENCES Usuarios(NomUsu)
)
GO

create TABLE Categorias (
    CodigoCat VARCHAR(3) PRIMARY KEY check(CodigoCat like '[a-zA-Z][a-zA-Z][a-zA-Z]'),
    NombreCat VARCHAR(30) NOT NULL
)
GO

CREATE TABLE Comunes (
    IdMensaje INT NOT NULL PRIMARY KEY,
    CodigoCategoria VARCHAR(3) not null,
    FOREIGN KEY (IdMensaje) REFERENCES Mensajes(IdMensaje),
    FOREIGN KEY (CodigoCategoria) REFERENCES Categorias(CodigoCat)
)
GO

Create TABLE Privados (
    IdMensaje INT FOREIGN KEY (IdMensaje) REFERENCES Mensajes(IdMensaje) PRIMARY KEY,
	FechaEnvio datetime not null default Getdate(),
    FechaCaducidad DATETIME NOT NULL, 
	check(datediff(hour, FechaEnvio, FechaCaducidad) >= 24)
)
GO

Create TABLE Recordatorios (
    IdMensaje INT FOREIGN KEY (IdMensaje) REFERENCES Mensajes(IdMensaje) PRIMARY KEY,
	TipoRecordatorio varchar (10) not null check(TipoRecordatorio in ('Laboral', 'Estudio', 'Personal'))
)
GO

CREATE TABLE Reciben (
    IdMensaje INT NOT NULL,
    NomUsuDestino VARCHAR(20) NOT NULL,
    PRIMARY KEY (IdMensaje, NomUsuDestino),
    FOREIGN KEY (IdMensaje) REFERENCES Mensajes(IdMensaje),
    FOREIGN KEY (NomUsuDestino) REFERENCES Usuarios(NomUsu)
)
GO


insert into Usuarios (NomUsu, ContraUsu, NomComUsu, FechaNacUsu, EmailUsu, UsuarioActivo) values
('ProGamer', 'asd_!123', 'Pedro Pedron', '12/06/1999', 'pedrogamer@gmail.com', 1),
('Juan2025', 'abc234_¿', 'Juan Riquelme', '23/01/1989', 'juanriquelme@hotmail.com', 1),
('Matias24', 'abc345_¿', 'Matias Perez', '04/01/2000', 'matiasperez24@hotmail.com', 1),
('Sabrina34', 'abc456_¿', 'Sabrina Flores', '11/07/1996', 'juanriquelme@hotmail.com', 1),
('Rodri123', 'abc567_¿', 'Rodrigo Baez', '12/12/2003', 'robaez@hotmail.com', 1),
('Pancho94', 'abc678_¿', 'Francisco Gimenez', '01/02/1994', 'federicogimenez@gmail.com', 1),
('Nacho061', 'abc789_¿', 'Ignacio Diaz', '21/11/2006', 'nachodiaz06@gmail.com', 1),
('gaturro12', 'abc890_¿', 'Alan Maturro', '07/10/1995', 'alanmaturro@hotmail.com', 1),
('UsuDam24', 'abc901_¿', 'Damian Gerez', '10/10/1990', 'damian24@gmail.com', 1),
('gabiram1', 'abc012_¿', 'Gabriela Ramirez', '11/06/1989', 'ramirezgabriela@hotmail.com', 1),
('LeoKing1', 'zxA123_!', 'Leonardo Castro', '15/05/1992', 'leoking92@gmail.com', 1),
('Valen071', 'QsW456_?', 'Valentina Ruiz', '20/08/2001', 'valenruiz07@yahoo.com', 1),
('TomyPlay', 'ErT789_!', 'Tomas Herrera', '29/12/1997', 'tomyh97@gmail.com', 1),
('AniSun90', 'UyP012_!', 'Ana Suarez', '14/03/1990', 'anita.sun@hotmail.com', 1),
('Charly25', 'LmN345_?', 'Carlos Ledesma', '22/06/1985', 'charly25@outlook.com', 1),
('Fern0901', 'OpK678_#', 'Fernando Guzman', '30/04/1999', 'fguzman09@gmail.com', 1),
('MicaBr01', 'RtY901_&', 'Micaela Bravo', '01/11/2002', 'micabravo@hotmail.com', 1),
('GonzaWeb', 'GhJ234_%', 'Gonzalo Rivas', '07/09/1993', 'gonza.rivas@gmail.com', 1),
('LuLu7777', 'ZxC567_!', 'Luciana Lugo', '18/01/2000', 'lulu77@outlook.com', 1),
('PatoXx12', 'VbN890_@', 'Patricio López', '25/12/1988', 'pato_xx@gmail.com', 1),
('SofiGm01', 'TgB321_!', 'Sofia Medina', '16/07/1994', 'sofiamedina@gmail.com', 1),
('MaxiDev1', 'YuH654_@', 'Maximiliano Torres', '10/10/1991', 'maxitorres@hotmail.com', 1),
('FioOnl11', 'IuJ987_#', 'Fiorella Campos', '28/02/2003', 'fioonline@outlook.com', 1),
('NicosXD1', 'PoL210_!', 'Nicolas Castro', '05/08/1996', 'nico_xd@gmail.com', 1),
('BrenRod1', 'AsD543_!', 'Brenda Rodriguez', '12/09/1995', 'brendar@hotmail.com', 1),
('LucasZz1', 'FgH876_#', 'Lucas Zabaleta', '23/05/1998', 'lucasz@gmail.com', 1),
('EmiSky01', 'JkL109_%', 'Emiliano Romero', '04/11/1992', 'emi.sky@hotmail.com', 1),
('LauPow01', 'MnB432_!', 'Laura Torres', '19/03/1990', 'laupower@outlook.com', 1),
('IvanaC01', 'QwE765_?', 'Ivana Caceres', '13/06/1997', 'ivanacaceres@gmail.com', 1),
('Josema01', 'RtY098_&', 'Jose Maria Vera', '27/04/1987', 'josema01@hotmail.com', 1),
('RomiPink1', 'UjM321_#', 'Romina Franco', '08/02/1991', 'ropink@gmail.com', 1),
('TeoGame1', 'Iko654_!', 'Teodoro Paredes', '09/12/1999', 'teogame@outlook.com', 1),
('MeliLov1', 'ZxA987_?', 'Melina Ramos', '26/06/2000', 'melilove@hotmail.com', 1),
('CrisTe01', 'CvB210_#', 'Cristian Tevez', '17/07/1994', 'cristiant@hotmail.com', 1),
('NatyRi01', 'ErT543_!', 'Natalia Rivero', '31/10/1986', 'natyrivero@gmail.com', 1),
('FranO991', 'YhG876_#', 'Franco Ojeda', '03/05/1999', 'franco99@hotmail.com', 1),
('CamCool1', 'LpO109_!', 'Camila Quiroga', '11/08/1993', 'camicool@gmail.com', 1),
('EstebMa1', 'UiY432_%', 'Esteban Martinez', '06/01/1991', 'estebanm@gmail.com', 1),
('DaniKr01', 'PoI765_#', 'Daniela Kruger', '21/09/2002', 'danikru@gmail.com', 1),
('SantiXP1', 'GhJ098_!', 'Santiago Paz', '02/04/1996', 'santixp@outlook.com', 1),
('FlorA281', 'ZxC321_?', 'Florencia Aguirre', '19/11/1998', 'flor28@gmail.com', 1),
('EugeRok1', 'VbN654_#', 'Eugenia Delgado', '12/01/2000', 'eugerock@hotmail.com', 1),
('Lucho271', 'YhT987_!', 'Luciano Godoy', '15/07/1992', 'lucho27@outlook.com', 1),
('MarcWeb1', 'MnB210_@', 'Marcelo Salas', '24/06/1989', 'marceweb@gmail.com', 1),
('AgusZo01', 'ErF543_!', 'Agustina Zorrilla', '09/03/1997', 'agusz@hotmail.com', 1),
('RodXxN01', 'TgV876_#', 'Rodrigo Navarro', '10/12/1985', 'rodrigoxx@gmail.com', 1),
('LuisaMa1', 'YuK109_!', 'Luisa Marquez', '01/09/2004', 'luisa.m@hotmail.com', 1),
('RamKl901', 'JkD432_%', 'Ramiro Klein', '07/02/1990', 'ramirok@gmail.com', 1),
('CataBl01', 'MnN765_#', 'Catalina Blanco', '18/04/2001', 'catab@outlook.com', 1),
('DiegoTi1', 'QwR098_!', 'Diego Tisera', '23/10/1993', 'diegot@gmail.com', 1),
('AiluV123', 'RtT321_?', 'Ailen Vargas', '14/06/1998', 'ailu123@gmail.com', 1),
('JimCool1', 'UjH654_!', 'Jimena Romero', '29/05/1997', 'jimecool@hotmail.com', 1),
('Tincho911', 'IkJ987_#', 'Agustin Tino', '06/07/1991', 'tino91@gmail.com', 1),
('RomiSo221', 'ZxE210_@', 'Romina Sosa', '25/12/1995', 'romi22@outlook.com', 1),
('AndRol01', 'CvU543_!', 'Andres Roldan', '02/11/1984', 'andresr@gmail.com', 1),
('EliStar1', 'FgY876_#', 'Eliana Vega', '13/03/1999', 'elistar@hotmail.com', 1),
('MartuXD1', 'JkQ109_!', 'Martina Lopez', '30/08/2000', 'martuxd@gmail.com', 1),
('FeliGo01', 'MnI432_%', 'Felipe Gonzalez', '16/01/1992', 'fegonzalez@outlook.com', 1),
('Carla109', 'PoP765_#', 'Carla Sanchez', '05/02/1994', 'carla09@hotmail.com', 1),
('GimePro1', 'GhA098_!', 'Gimena Morales', '11/05/1996', 'gimepro@gmail.com', 1),
('AleTap01', 'ZxT321_?', 'Alejo Tapia', '22/04/1990', 'alejot@hotmail.com', 1)
go

insert into Categorias(CodigoCat, NombreCat) values
('scl', 'social'),
('rnn', 'reunion'),
('trs', 'tareas'),
('obt', 'obligatorio'),
('vcs', 'vacaciones'),
('fst', 'fiesta'),
('ntc', 'noticias'),
('cmd', 'comunicado'),
('prm', 'promociones'),
('ntf', 'notificacion'),
('dst', 'destacado')
go


INSERT INTO Mensajes (Asunto, Texto, UsuarioEmisor) VALUES 
('Reunión importante', 'Veniam molestias beatae porro dolores ullam illum consequuntur sint quia dolore vel.', 'Pancho94'),
('Consulta rápida', 'Enim amet occaecati hic eligendi ut ad illo ab natus eligendi accusantium fugit mollitia nulla quisquam laborum.', 'AleTap01'),
('Solicitud de ayuda', 'Nemo voluptas dignissimos doloremque quos asperiores omnis.', 'Carla109'),
('Resultado de evaluación', 'Quod recusandae distinctio ipsam fuga excepturi.', 'Sabrina34'),
('Entrega de proyecto', 'Quas quaerat ab harum nisi impedit eveniet corrupti dolor distinctio id veniam quia quo.', 'RomiSo221'),
('Reunión importante', 'Optio officia molestiae aliquid repellat deleniti accusantium eum blanditiis dolores et.', 'Carla109'),
('Reunión importante', 'Perferendis et deserunt nesciunt reprehenderit autem quo sequi natus occaecati voluptates quia.', 'EmiSky01'),
('Reunión importante', 'Ab delectus error eum magni voluptatem illum qui ipsam.', 'RamKl901'),
('Reunión importante', 'Expedita dolorum perferendis dicta suscipit eveniet rerum vel velit fugiat.', 'EstebMa1'),
('Recordatorio', 'Necessitatibus voluptatem assumenda veniam consequatur vero sint eos asperiores aspernatur consequuntur nesciunt.', 'Rodri123'),
('Suspensión de clase', 'Minus nisi consectetur temporibus porro.', 'EmiSky01'),
('Recordatorio', 'Asperiores consequuntur nemo cupiditate quisquam consequatur minus.', 'Juan2025'),
('Suspensión de clase', 'Doloribus sint quis eos expedita fugit eveniet velit nisi corporis dolorem.', 'TeoGame1'),
('Resultado de evaluación', 'Consequuntur eveniet natus sint autem excepturi nostrum.', 'Rodri123'),
('Suspensión de clase', 'Pariatur eos aliquam accusamus sapiente esse optio incidunt in officiis nostrum minus.', 'LuisaMa1'),
('Invitación', 'Nisi impedit facere necessitatibus aut ipsam sit incidunt beatae ipsa esse.', 'ProGamer'),
('Suspensión de clase', 'Cumque nobis necessitatibus deleniti cum unde at suscipit facilis recusandae.', 'FioOnl11'),
('Felicitaciones', 'Laudantium magnam aliquam eius inventore nam nesciunt eligendi incidunt deserunt possimus dolores officia voluptate dolore ad.', 'AniSun90'),
('Suspensión de clase', 'Unde nihil dolore assumenda optio neque optio fugiat commodi assumenda eaque rem facere.', 'EmiSky01'),
('Solicitud de ayuda', 'Distinctio explicabo quod corporis libero laudantium delectus eveniet placeat.', 'Carla109'),
('Invitación', 'Ea odio occaecati magni doloribus ut dolores officia animi fuga incidunt.', 'Nacho061'),
('Cambio de horario', 'Neque unde libero deleniti delectus adipisci commodi nihil beatae culpa ex.', 'AndRol01'),
('Resultado de evaluación', 'Minus velit saepe consequatur impedit delectus possimus aliquam esse.', 'MicaBr01'),
('Felicitaciones', 'Dolorum enim a dolorum quos numquam odit dignissimos provident vero ad.', 'MartuXD1'),
('Felicitaciones', 'Quibusdam ipsam itaque eum quisquam minima quas ipsa at aperiam odit quod officia assumenda sit fugit hic.', 'Valen071'),
('Saludo', 'Deleniti voluptate velit aliquam magnam esse nemo possimus veniam animi cumque earum illo dolorum.', 'MaxiDev1'),
('Recordatorio', 'Deserunt laboriosam odio eum adipisci quidem corporis.', 'RamKl901'),
('Cambio de horario', 'Dolore quos quos quod optio illo pariatur.', 'MaxiDev1'),
('Examen próximo', 'In itaque illum impedit saepe distinctio ab neque voluptatibus odio vero.', 'GonzaWeb'),
('Saludo', 'Debitis fugiat dicta suscipit quam sed voluptate tenetur accusantium.', 'Nacho061'),
('Felicitaciones', 'Nobis consequatur eius quisquam voluptas dicta assumenda.', 'EugeRok1'),-------------------------------
('Suspensión de clase', 'Dolor minima accusantium eveniet voluptatibus aperiam minus dolorem.', 'TeoGame1'),
('Entrega de proyecto', 'Asperiores laborum mollitia ut quae occaecati ipsa neque dolores quod rem molestias.', 'NicosXD1'),
('Resultado de evaluación', 'Aliquid officia aliquam incidunt totam ut laboriosam ad a placeat dignissimos.', 'LuisaMa1'),
('Solicitud de ayuda', 'Nesciunt at autem soluta illum provident deleniti voluptates quibusdam delectus inventore dolor veniam perferendis.', 'AgusZo01'),
('Consulta rápida', 'Id velit hic fugit error earum consequuntur neque optio eum.', 'LauPow01'),
('Reunión importante', 'Magni facilis velit adipisci asperiores optio laudantium qui aut.', 'Nacho061'),
('Anuncio urgente', 'Quod tempore maxime iusto accusantium sequi debitis ipsa praesentium consequatur error magnam rem cum deleniti sed.', 'MeliLov1'),
('Reunión importante', 'Consectetur nemo temporibus dolore illum laudantium officiis.', 'Charly25'),
('Actualización', 'Commodi quam incidunt quia fugit consequuntur voluptates asperiores accusantium porro dolorem assumenda corporis pariatur magnam amet eligendi quisquam asperiores.', 'Carla109'),
('Reunión importante', 'Incidunt nisi fugit nam aliquid quam architecto quis deleniti possimus quaerat neque neque repudiandae suscipit et provident omnis laudantium.', 'Lucho271'),
('Solicitud de ayuda', 'Fuga quae veniam sit a eligendi debitis error veniam nam atque placeat deleniti vitae.', 'DiegoTi1'),
('Saludo', 'Sit repudiandae tempora magni cupiditate rem delectus molestias molestias deserunt vero.', 'RodXxN01'),
('Saludo', 'Deserunt architecto consequatur quisquam quos incidunt similique minima saepe mollitia soluta unde id ducimus excepturi pariatur quam asperiores.', 'GimePro1'),
('Tarea nueva', 'Rerum sapiente labore consectetur facilis vero praesentium quam debitis tempore.', 'Sabrina34'),
('Saludo', 'Nesciunt animi esse corrupti deleniti ipsa pariatur tenetur porro enim sapiente ut.', 'EugeRok1'),
('Tarea nueva', 'Iste cum non assumenda animi debitis exercitationem ex aspernatur officiis facilis velit sunt ad praesentium.', 'LucasZz1'),
('Examen próximo', 'Nesciunt officiis nisi corporis autem quo repellat ullam placeat mollitia ipsum sapiente ipsum.', 'TomyPlay'),
('Examen próximo', 'Nam similique quibusdam officiis vero in ad vero illum non.', 'Juan2025'),
('Tarea nueva', 'Distinctio deserunt quasi impedit occaecati quasi perspiciatis quasi ex occaecati veritatis a voluptatem.', 'CrisTe01'),
('Resultado de evaluación', 'Officia in neque harum neque architecto atque earum nesciunt rerum repellendus quae fugiat.', 'RomiPink1'),
('Saludo', 'Facere nobis nesciunt commodi ratione vel quis ex.', 'RomiSo221'),
('Anuncio urgente', 'Voluptate nulla ipsam dolores atque praesentium a numquam explicabo quia qui doloremque.', 'FioOnl11'),
('Cambio de horario', 'Modi eveniet nulla nemo eveniet aliquam eum.', 'MaxiDev1'),
('Anuncio urgente', 'Aut impedit totam vel fugiat expedita nobis necessitatibus.', 'LauPow01'),
('Examen próximo', 'Doloribus earum pariatur quasi a occaecati libero optio quis.', 'Sabrina34'),
('Recordatorio', 'Tempora asperiores officia itaque repellat atque.', 'AiluV123'),
('Solicitud de ayuda', 'Cum mollitia tempore vero quas repellendus delectus sapiente iure architecto sint repellat adipisci harum numquam.', 'FlorA281'),
('Saludo', 'Quo sit nesciunt assumenda nemo sed ipsa quas.', 'NatyRi01'),------------------------------------------
('Resultado de evaluación', 'Commodi inventore exercitationem fuga libero vel.', 'LuLu7777'),
('Entrega de proyecto', 'Deserunt sit debitis ab impedit consequatur occaecati quas.', 'CrisTe01'),
('Saludo', 'Possimus quas ut autem magni dolorem.', 'Matias24'),
('Examen próximo', 'Nisi beatae sapiente assumenda aliquam omnis eveniet deleniti beatae.', 'EugeRok1'),
('Anuncio urgente', 'Et nihil amet minima laudantium neque ut placeat eveniet labore magni.', 'DaniKr01'),
('Tarea nueva', 'Odit expedita suscipit aliquid cupiditate eius vero soluta doloribus nesciunt enim vel numquam quas ut rem ut corrupti.', 'CrisTe01'),
('Felicitaciones', 'Deserunt accusamus laudantium est vero quibusdam ab fuga rem sit.', 'AiluV123'),
('Actualización', 'Dolores deserunt quod vel debitis ducimus aut cumque sequi neque sint.', 'CamCool1'),
('Saludo', 'Fugit ut repudiandae sapiente rem quas temporibus eum ullam impedit quidem expedita.', 'MicaBr01'),
('Reunión importante', 'Id adipisci eligendi minima temporibus esse laudantium nostrum consectetur alias.', 'FeliGo01'),
('Solicitud de ayuda', 'Hic a doloremque aut harum eius quod accusamus.', 'LuisaMa1'),
('Tarea nueva', 'Voluptatibus ad reprehenderit magni eaque corrupti dignissimos enim.', 'AndRol01'),
('Anuncio urgente', 'Assumenda suscipit iure ad quidem quidem.', 'LauPow01'),
('Entrega de proyecto', 'Veritatis officiis soluta iure nulla non vitae ullam voluptates ut.', 'Tincho911'),
('Consulta rápida', 'Quis officiis voluptatibus minima sed quos nobis temporibus perspiciatis provident fugit aut illum.', 'SantiXP1'),
('Reunión importante', 'Repellendus excepturi placeat rerum numquam doloribus.', 'Sabrina34'),
('Anuncio urgente', 'Eos alias cupiditate voluptas odio impedit porro ex blanditiis nisi.', 'GonzaWeb'),
('Saludo', 'Optio officia qui aliquid ullam autem.', 'FranO991'),
('Consulta rápida', 'Labore illum quidem dolor impedit cupiditate aut ratione.', 'JimCool1'),
('Suspensión de clase', 'Enim cum sit sapiente odit saepe.', 'LuisaMa1'),
('Examen próximo', 'Harum doloremque beatae corrupti cum fugiat.', 'FeliGo01'),
('Entrega de proyecto', 'Numquam accusamus praesentium harum sequi sequi ducimus eveniet quae repellat natus dignissimos qui optio voluptate adipisci dolorum.', 'FlorA281'),
('Suspensión de clase', 'Quidem non architecto asperiores esse harum neque reiciendis.', 'gabiram1'),
('Recordatorio', 'Hic repellendus exercitationem vero dolor sed quidem quod recusandae alias deleniti consequatur eaque ipsa delectus labore earum.', 'AleTap01'),
('Consulta rápida', 'Sed officiis vitae occaecati vel rem tempora fuga atque corporis odit.', 'FioOnl11'),
('Recordatorio', 'Ipsam recusandae perspiciatis dignissimos deleniti dicta eaque dolorum molestias dolores nemo numquam.', 'MeliLov1'),
('Felicitaciones', 'Optio quis laborum adipisci ex occaecati laboriosam ullam delectus adipisci ipsam.', 'PatoXx12'),
('Solicitud de ayuda', 'Dolore numquam sapiente sunt quis praesentium a officia iusto repellendus dolor quod porro.', 'Sabrina34'),
('Recordatorio', 'Odit repellendus minima tempora assumenda ratione sunt ratione blanditiis.', 'JimCool1'),
('Suspensión de clase', 'Iusto error beatae quas voluptates pariatur nam aperiam pariatur aliquam consequuntur officiis similique magni quod minima.', 'gabiram1'),
('Cambio de horario', 'Nostrum enim aut labore velit distinctio quibusdam atque maiores maiores deleniti nemo tempore.', 'TeoGame1'),
('Recordatorio', 'Totam eaque quia quo aspernatur temporibus quas quia deleniti consectetur.', 'EstebMa1'),
('Solicitud de ayuda', 'Voluptas laborum velit facere iste ducimus quibusdam voluptatibus eveniet suscipit doloribus accusantium consequatur asperiores incidunt.', 'CataBl01'),
('Examen próximo', 'Aspernatur nemo ea expedita rem soluta perferendis quia veniam necessitatibus sapiente corrupti.', 'AgusZo01'),
('Examen próximo', 'Aliquid accusantium dolorem recusandae quae sunt exercitationem tempora repellendus ipsa.', 'Pancho94'),
('Actualización', 'Eveniet nisi dolorem eligendi quidem suscipit a repellendus saepe voluptate perferendis consequuntur veritatis.', 'RodXxN01'),
('Reunión importante', 'Quia magni perspiciatis nemo magnam assumenda harum hic itaque repudiandae.', 'Juan2025'),
('Cambio de horario', 'Fugit debitis similique explicabo nulla odit quae tempore.', 'FranO991'),
('Felicitaciones', 'Fugiat nostrum sed minima reprehenderit ea quos omnis accusantium alias nihil porro.', 'Sabrina34'),
('Reunión importante', 'Consequatur blanditiis doloribus rem consectetur ea minus.', 'RodXxN01'),
('Felicitaciones', 'Qui deleniti est ullam magnam officiis doloremque quasi error nisi modi mollitia veniam explicabo a consectetur.', 'ProGamer'),
('Saludo', 'Pariatur atque eaque inventore laudantium odit illum.', 'CataBl01'),
('Consulta rápida', 'Quasi at possimus deleniti iure.', 'LuisaMa1'),
('Invitación', 'Accusamus facilis unde totam eveniet enim nulla dicta dolore non deleniti ea ab labore.', 'CamCool1'),
('Solicitud de ayuda', 'Excepturi quasi libero consequuntur asperiores maxime neque porro quasi eveniet assumenda sed assumenda saepe.', 'TomyPlay'),
('Consulta rápida', 'Doloremque cum doloremque atque eligendi ducimus natus ratione eligendi nostrum eveniet autem id.', 'NicosXD1'),
('Recordatorio', 'Tempore cumque optio pariatur nulla delectus inventore enim reiciendis.', 'Matias24'),
('Resultado de evaluación', 'Laborum consequatur architecto blanditiis ipsa tenetur itaque veniam vero nihil mollitia.', 'NicosXD1'),
('Consulta rápida', 'Cupiditate repudiandae ab ipsa suscipit officiis dolorem accusantium labore omnis odit.', 'AiluV123'),
('Reunión importante', 'Magnam nesciunt neque itaque eum eius qui quidem.', 'Lucho271'),
('Recordatorio', 'Ex similique cum et numquam ipsa quam pariatur officiis iusto architecto sequi eius aliquid molestias.', 'GimePro1'),
('Felicitaciones', 'Impedit voluptate eligendi quae optio reiciendis repudiandae quaerat placeat natus voluptatum.', 'Juan2025'),
('Cambio de horario', 'Perferendis quas enim ipsam libero accusamus commodi cupiditate aliquid dolorum alias.', 'Carla109'),
('Examen próximo', 'Quae aspernatur distinctio voluptate maiores molestias dignissimos quasi repellat consequuntur.', 'FioOnl11'),
('Tarea nueva', 'Officiis blanditiis nostrum neque reiciendis natus.', 'FioOnl11'),
('Entrega de proyecto', 'Voluptate ullam perspiciatis libero nostrum.', 'gaturro12'),
('Consulta rápida', 'Aliquam magni modi reprehenderit facere deserunt voluptate similique.', 'MeliLov1'),
('Reunión importante', 'Corporis aut explicabo tempore reiciendis sint officia nobis earum reprehenderit ipsa soluta et fuga.', 'EugeRok1'),
('Tarea nueva', 'Maiores dignissimos odio commodi sint perspiciatis saepe consequuntur enim qui animi.', 'Nacho061'),
('Cambio de horario', 'Quae fugit officia ea nam alias consequatur deserunt fugiat neque itaque incidunt vero.', 'IvanaC01'),
('Reunión importante', 'Odio fuga vitae commodi nam consectetur molestias itaque earum provident aperiam nisi illo ex explicabo molestiae labore itaque ut.', 'DiegoTi1'),
('Entrega de proyecto', 'Nobis id corporis dolore deserunt ratione animi ratione iure quasi saepe odit nulla deleniti.', 'Rodri123'),
('Anuncio urgente', 'At earum odio temporibus quo aspernatur animi.', 'Tincho911'),
('Recordatorio', 'Id quae inventore iusto reiciendis recusandae maxime perspiciatis esse nesciunt odio.', 'FlorA281'),
('Entrega de proyecto', 'Doloremque voluptates molestias iste adipisci animi officia eveniet sint fugiat hic ducimus.', 'Carla109'),
('Invitación', 'Dicta natus libero optio voluptatum similique sint error similique sit nostrum harum velit ut architecto.', 'EmiSky01'),
('Suspensión de clase', 'Voluptatem animi repudiandae iusto dolor ipsum cumque nobis minus cum rem quas ad laboriosam quod odio.', 'Tincho911'),
('Recordatorio', 'Dolor rem officiis corrupti laudantium officia veniam dolor nobis asperiores hic mollitia.', 'PatoXx12'),
('Cambio de horario', 'Cumque laboriosam enim molestias blanditiis nesciunt ad non veritatis.', 'Juan2025'),
('Suspensión de clase', 'Veritatis minima nemo sit ipsum asperiores maxime eum magnam veniam.', 'RomiSo221'),
('Examen próximo', 'Exercitationem perspiciatis nobis ipsam nam soluta ipsa ex optio.', 'NicosXD1'),
('Cambio de horario', 'Officiis officiis quod sapiente voluptates quam consectetur.', 'TeoGame1'),
('Solicitud de ayuda', 'Molestias quas ipsum quo explicabo cupiditate alias doloremque quis similique quaerat excepturi.', 'Pancho94'),
('Saludo', 'Consequatur inventore magnam voluptas architecto maiores repellendus eaque quisquam dignissimos minima eveniet.', 'UsuDam24'),
('Examen próximo', 'Perferendis neque cum accusamus saepe delectus deleniti nemo.', 'PatoXx12'),
('Consulta rápida', 'Quibusdam nisi eveniet eveniet maiores nihil quas maxime quidem quae et rerum tempore hic itaque voluptas voluptate ducimus quis.', 'UsuDam24'),
('Anuncio urgente', 'Ut esse aliquam harum quasi occaecati esse magni at voluptas expedita suscipit.', 'MaxiDev1'),
('Resultado de evaluación', 'At cumque repudiandae nesciunt ullam assumenda asperiores officia.', 'TeoGame1'),
('Recordatorio', 'Architecto nemo id dolorum facere autem nulla maiores ex eveniet.', 'CataBl01'),
('Solicitud de ayuda', 'Nisi dolorem aliquid sed sit adipisci sed optio placeat reiciendis pariatur beatae.', 'LuLu7777'),
('Reunión importante', 'Corporis deleniti minus officia laborum blanditiis dicta.', 'TomyPlay'),
('Solicitud de ayuda', 'Doloribus corporis quia provident deserunt reiciendis voluptatibus aspernatur culpa blanditiis quasi.', 'MeliLov1'),
('Examen próximo', 'Itaque sint recusandae cumque dolorum officia eos esse dolorem corporis accusantium iste laudantium.', 'gabiram1'),
('Saludo', 'Commodi fuga deleniti eaque culpa quos asperiores voluptatibus iure eos.', 'MeliLov1'),
('Resultado de evaluación', 'Explicabo eius dolore quas assumenda dolores harum sit.', 'Matias24'),
('Entrega de proyecto', 'Commodi nisi vel fugit nihil ea reiciendis nihil officia molestiae.', 'FranO991'),
('Tarea nueva', 'Quasi quasi quibusdam officiis cupiditate dolorem tempore atque ratione.', 'MaxiDev1'),
('Suspensión de clase', 'Quam commodi similique architecto laboriosam saepe debitis odit quam doloremque magnam aspernatur illum quia debitis.', 'LuisaMa1'),
('Suspensión de clase', 'Ex explicabo doloremque cupiditate tenetur repudiandae non at doloribus dicta minima.', 'AiluV123'),
('Cambio de horario', 'Accusantium non reiciendis veniam eveniet nisi veniam nulla magni.', 'FranO991'),
('Anuncio urgente', 'Occaecati nam modi inventore earum quam alias accusantium recusandae labore.', 'GimePro1'),
('Invitación', 'Voluptas quam dolore quae fuga impedit esse facilis fugiat quasi asperiores.', 'EstebMa1'),
('Suspensión de clase', 'Non dolorem placeat aliquid autem quae rem fugiat distinctio voluptatem.', 'TeoGame1'),
('Solicitud de ayuda', 'Praesentium dolores hic ab magnam non ad velit iusto cupiditate nemo repellendus veniam iure.', 'Pancho94'),
('Suspensión de clase', 'Ducimus labore magni minima distinctio nostrum.', 'FioOnl11'),
('Resultado de evaluación', 'Maiores asperiores quas maxime incidunt fuga maxime animi ipsam quis iusto maiores esse sit error debitis.', 'MaxiDev1'),
('Consulta rápida', 'Optio alias corrupti possimus cum aliquam necessitatibus quos cum.', 'MicaBr01'),
('Entrega de proyecto', 'Inventore nulla tenetur minus labore voluptatibus quasi tempore maxime soluta corporis repellendus.', 'SofiGm01'),
('Anuncio urgente', 'Doloremque a quibusdam deserunt reiciendis unde nemo.', 'FeliGo01'),
('Resultado de evaluación', 'Possimus deserunt dignissimos dignissimos sequi vel a atque inventore nesciunt maiores placeat voluptas.', 'UsuDam24'),
('Reunión importante', 'Magni tempora veritatis unde eius.', 'Tincho911'),
('Reunión importante', 'Quae ab quis sit cumque dolorem et fugit voluptate quod eum.', 'GonzaWeb'),
('Invitación', 'Omnis eos cum sint aperiam iste doloremque necessitatibus corrupti cupiditate repellat.', 'MaxiDev1'),
('Recordatorio', 'Doloremque optio dolores similique incidunt animi provident magnam voluptas quibusdam perspiciatis eaque odio a nostrum ab ipsum iste animi hic.', 'SantiXP1'),
('Actualización', 'Rem aut incidunt pariatur reprehenderit corporis ratione vitae odio accusantium quo eaque asperiores consequuntur earum.', 'Valen071'),
('Recordatorio', 'Ut aspernatur doloribus distinctio rem ipsam adipisci fugit distinctio aperiam aut.', 'Josema01'),
('Felicitaciones', 'Tenetur aut inventore dignissimos fugit alias sed a qui magnam numquam ab ab enim.', 'Lucho271'),
('Resultado de evaluación', 'Velit est velit placeat incidunt quisquam.', 'AiluV123'),
('Entrega de proyecto', 'Natus libero hic neque odit quaerat quia architecto quisquam neque ipsa minima cum.', 'AiluV123'),
('Recordatorio', 'Id error sunt ad reiciendis facilis debitis ex.', 'gaturro12'),
('Recordatorio', 'Ipsum placeat delectus quae laudantium unde expedita delectus nemo laboriosam tenetur sit quis a.', 'Rodri123'),
('Tarea nueva', 'Doloribus dolores iusto nobis consequatur illum unde maxime modi ducimus magni cum.', 'Charly25'),
('Cambio de horario', 'Dolorum assumenda adipisci voluptatum atque occaecati voluptates aliquam.', 'MeliLov1'),
('Anuncio urgente', 'Quas voluptatum cumque praesentium in incidunt incidunt delectus asperiores eveniet in corporis dolorem magni dicta.', 'SantiXP1'),
('Suspensión de clase', 'Et laudantium fugiat perferendis sunt laborum consectetur ullam eaque voluptas perspiciatis molestias.', 'TeoGame1'),
('Reunión importante', 'Repellendus quisquam asperiores debitis labore cupiditate soluta quasi.', 'NicosXD1'),
('Anuncio urgente', 'Repudiandae similique cum ratione cum beatae totam exercitationem cupiditate aspernatur.', 'MartuXD1'),
('Anuncio urgente', 'Dignissimos illo fugiat consectetur maxime fugit delectus laborum harum dolorum illum molestiae laboriosam debitis sint magni perferendis.', 'AleTap01'),
('Felicitaciones', 'Maiores nulla possimus eos illo harum eligendi sint alias sed dolorum.', 'PatoXx12'),
('Resultado de evaluación', 'Quaerat iusto molestias nihil necessitatibus aliquam quod quaerat.', 'Nacho061'),
('Saludo', 'Suscipit doloremque voluptas eum ea doloribus unde maxime aperiam.', 'Matias24'),
('Solicitud de ayuda', 'Nisi delectus et ea error eum quia minus adipisci ut eos iusto atque.', 'gaturro12'),
('Consulta rápida', 'Quod aliquid consequuntur debitis tempora a id vitae vel repellendus minus exercitationem quasi non porro.', 'EstebMa1'),
('Entrega de proyecto', 'Repudiandae ratione consequuntur labore recusandae dolor fugit earum voluptates quam adipisci iure veritatis occaecati.', 'gaturro12'),
('Tarea nueva', 'Neque quibusdam cum ex quod iure consectetur quos impedit corporis quod voluptate eum.', 'AgusZo01'),
('Reunión importante', 'Magnam perspiciatis labore molestias consequuntur voluptatum corrupti illo beatae expedita dolore fuga.', 'CataBl01'),
('Felicitaciones', 'Magnam minus quibusdam magni explicabo tempore molestiae sed incidunt facilis.', 'UsuDam24'),
('Resultado de evaluación', 'Sunt quas ut ullam similique expedita beatae blanditiis officiis asperiores reiciendis voluptas placeat tenetur recusandae rerum.', 'CrisTe01'),
('Actualización', 'Impedit enim commodi porro non placeat quos tempore beatae.', 'MicaBr01'),
('Reunión importante', 'Cum assumenda consequuntur soluta temporibus quo ipsam iste iste accusamus laborum pariatur necessitatibus.', 'LuisaMa1'),
('Consulta rápida', 'Nobis perferendis vitae occaecati illo inventore nisi animi ipsam delectus dolorum.', 'RodXxN01'),
('Consulta rápida', 'Sapiente eveniet id explicabo totam ut ea minima tenetur laboriosam.', 'Valen071'),
('Felicitaciones', 'In autem quasi tempore sequi voluptatibus est velit dolor natus sapiente atque.', 'EugeRok1'),
('Examen próximo', 'Exercitationem non explicabo labore esse quas alias ad magnam dolor omnis maiores consectetur impedit repellendus.', 'Charly25'),
('Reunión importante', 'Perferendis esse consequuntur corrupti saepe id veritatis quas minima repudiandae autem labore officia dolores corporis optio.', 'GonzaWeb'),
('Felicitaciones', 'Fuga est ducimus ratione aperiam et voluptate placeat distinctio.', 'LuisaMa1'),
('Resultado de evaluación', 'Dolore assumenda earum nulla tenetur sunt tempora quisquam ratione.', 'GonzaWeb'),
('Felicitaciones', 'Cumque a exercitationem placeat ex porro repellat quasi.', 'DaniKr01'),
('Solicitud de ayuda', 'Porro magni accusamus temporibus nesciunt deleniti fugit consectetur alias quo illo iure.', 'RomiPink1'),
('Felicitaciones', 'Illum ipsam harum illum quam accusantium dolore officia.', 'CataBl01'),
('Entrega de proyecto', 'Soluta asperiores architecto architecto velit aspernatur.', 'NicosXD1')
go


insert into Privados (IdMensaje, FechaCaducidad) values
(1, '20250806'),
(2, '20250805'),
(3, '20250927'),
(4, '20250805'),
(5, '20251027'),
(6, '20250902'),
(7, '20250830'),
(8, '20250828'),
(9, '20250805'),
(10, '20250805'),
(11, '20251030'),
(12, '20250821'),
(13, '20251127'),
(14, '20251228'),
(15, '20250829'),
(16, '20250927'),
(17, '20250928'),
(18, '20250929'),
(19, '20251002'),
(20, '20251130'),
(21, '20250829'),
(22, '20250810'),
(23, '20251215'),
(24, '20250809'),
(25, '20251212'),
(26, '20250812'),
(27, '20251101'),
(28, '20251105'),
(29, '20251001'),
(30, '20251010')
go

insert into Recordatorios(IdMensaje, TipoRecordatorio) values
(31, 'Laboral'),
(32, 'Estudio'),
(33, 'Personal'),
(34, 'Estudio'),
(35, 'Estudio'),
(36, 'Laboral'),
(37, 'Estudio'),
(38, 'Laboral'),
(39, 'Estudio'),
(40, 'Estudio'),
(41, 'Estudio'),
(42, 'Estudio'),
(43, 'Personal'),
(44, 'Personal'),
(45, 'Personal'),
(46, 'Estudio'),
(47, 'Laboral'),
(48, 'Estudio'),
(49, 'Laboral'),
(50, 'Laboral'),
(51, 'Personal'),
(52, 'Laboral'),
(53, 'Laboral'),
(54, 'Estudio'),
(55, 'Personal'),
(56, 'Laboral'),
(57, 'Laboral'),
(58, 'Estudio'),
(59, 'Personal'),
(60, 'Laboral'),
(181, 'Estudio'),
(182, 'Personal'),
(183, 'Laboral'),
(184, 'Estudio'),
(185, 'Personal'),
(186, 'Laboral'),
(187, 'Personal'),
(188, 'Laboral'),
(189, 'Estudio'),
(190, 'Laboral'),
(191, 'Estudio'),
(192, 'Personal'),
(193, 'Personal'),
(194, 'Estudio'),
(195, 'Laboral'),
(196, 'Laboral'),
(197, 'Personal'),
(198, 'Estudio'),
(199, 'Personal'),
(200, 'Laboral')
go

insert into Comunes(IdMensaje, CodigoCategoria) values
(61, 'scl'),
(62, 'rnn'),
(63, 'cmd'),
(64, 'trs'),
(65, 'obt'),
(66, 'vcs'),
(67, 'fst'),
(68, 'ntc'),
(69, 'prm'),
(70, 'ntf'),
(71, 'cmd'),
(72, 'cmd'),
(73, 'cmd'),
(74, 'cmd'),
(75, 'cmd'),
(76, 'cmd'),
(77, 'cmd'),
(78, 'cmd'),
(79, 'cmd'),
(80, 'cmd'),
(81, 'scl'),
(82, 'scl'),
(83, 'scl'),
(84, 'scl'),
(85, 'scl'),
(86, 'scl'),
(87, 'scl'),
(88, 'scl'),
(89, 'scl'),
(90, 'scl'),
(91, 'rnn'),
(92, 'rnn'),
(93, 'rnn'),
(94, 'rnn'),
(95, 'rnn'),
(96, 'rnn'),
(97, 'rnn'),
(98, 'rnn'),
(99, 'rnn'),
(100, 'rnn'),
(101, 'trs'),
(102, 'trs'),
(103, 'trs'),
(104, 'trs'),
(105, 'trs'),
(106, 'trs'),
(107, 'trs'),
(108, 'trs'),
(109, 'trs'),
(110, 'trs'),
(111, 'obt'),
(112, 'obt'),
(113, 'obt'),
(114, 'obt'),
(115, 'obt'),
(116, 'obt'),
(117, 'obt'),
(118, 'obt'),
(119, 'obt'),
(120, 'obt'),
(121, 'vcs'),
(122, 'vcs'),
(123, 'vcs'),
(124, 'vcs'),
(125, 'vcs'),
(126, 'vcs'),
(127, 'vcs'),
(128, 'vcs'),
(129, 'vcs'),
(130, 'vcs'),
(131, 'fst'),
(132, 'fst'),
(133, 'fst'),
(134, 'fst'),
(135, 'fst'),
(136, 'fst'),
(137, 'fst'),
(138, 'fst'),
(139, 'fst'),
(140, 'fst'),
(141, 'ntc'),
(142, 'ntc'),
(143, 'ntc'),
(144, 'ntc'),
(145, 'ntc'),
(146, 'ntc'),
(147, 'ntc'),
(148, 'ntc'),
(149, 'ntc'),
(150, 'ntc'),
(151, 'prm'),
(152, 'prm'),
(153, 'prm'),
(154, 'prm'),
(155, 'prm'),
(156, 'prm'),
(157, 'prm'),
(158, 'prm'),
(159, 'prm'),
(160, 'prm'),
(161, 'ntf'),
(162, 'ntf'),
(163, 'ntf'),
(164, 'ntf'),
(165, 'ntf'),
(166, 'ntf'),
(167, 'ntf'),
(168, 'ntf'),
(169, 'ntf'),
(170, 'ntf'),
(171, 'dst'),
(172, 'dst'),
(173, 'dst'),
(174, 'dst'),
(175, 'dst'),
(176, 'dst'),
(177, 'dst'),
(178, 'dst'),
(179, 'dst'),
(180, 'dst')
go


insert into Reciben(IdMensaje, NomUsuDestino) values
(61, 'Pancho94'),
(62, 'Juan2025'),
(63, 'Rodri123'),
(64, 'Sabrina34'),
(65, 'ProGamer'),
(66, 'CamCool1'),
(67, 'Nacho061'),
(68, 'gaturro12'),
(69, 'UsuDam24'),
(70, 'gabiram1'),
(71, 'Pancho94'),
(72, 'Juan2025'),
(73, 'Rodri123'),
(74, 'Sabrina34'),
(75, 'ProGamer'),
(76, 'CamCool1'),
(77, 'Nacho061'),
(78, 'gaturro12'),
(79, 'UsuDam24'),
(80, 'gabiram1'),
(81, 'LeoKing1'),
(82, 'Rodri123'),
(83, 'Rodri123'),
(84, 'Sabrina34'),
(85, 'LeoKing1'),
(86, 'Valen071'),
(87, 'TomyPlay'),
(88, 'AniSun90'),
(89, 'Charly25'),
(90, 'Fern0901'),
(91, 'MicaBr01'),
(92, 'GonzaWeb'),
(93, 'LuLu7777'),
(94, 'PatoXx12'),
(95, 'SofiGm01'),
(96, 'MaxiDev1'),
(97, 'FioOnl11'),
(98, 'NicosXD1'),
(99, 'BrenRod1'),
(100, 'LucasZz1'),
(101, 'EmiSky01'),
(102, 'LauPow01'),
(103, 'IvanaC01'),
(104, 'Josema01'),
(105, 'RomiPink1'),
(106, 'TeoGame1'),
(107, 'MeliLov1'),
(108, 'CrisTe01'),
(109, 'NatyRi01'),
(110, 'FranO991')
go


insert into Reciben(IdMensaje, NomUsuDestino) values
(111, 'AleTap01'),
(111, 'GimePro1'),
(112, 'Carla109'),
(112, 'FeliGo01'),
(113, 'MartuXD1'),
(113, 'EliStar1'),
(114, 'AndRol01'),
(114, 'RomiSo221'),
(115, 'Tincho911'),
(115, 'JimCool1'),
(116, 'AiluV123'),
(116, 'DiegoTi1'),
(117, 'CataBl01'),
(117, 'RamKl901'),
(118, 'LuisaMa1'),
(118, 'RodXxN01'),
(119, 'AgusZo01'),
(119, 'MarcWeb1'),
(120, 'Lucho271'),
(120, 'EugeRok1'),
(121, 'FlorA281'),
(121, 'SantiXP1'),
(122, 'DaniKr01'),
(122, 'EstebMa1'),
(123, 'CamCool1'),
(123, 'FranO991'),
(124, 'NatyRi01'),
(124, 'CrisTe01'),
(125, 'MeliLov1'),
(125, 'TeoGame1'),
(126, 'RomiPink1'),
(126, 'Josema01'),
(127, 'IvanaC01'),
(127, 'LauPow01'),
(128, 'EmiSky01'),
(128, 'LucasZz1'),
(129, 'BrenRod1'),
(129, 'NicosXD1'),
(130, 'FioOnl11'),
(130, 'MaxiDev1')
go

insert into Reciben(IdMensaje, NomUsuDestino) values
(31, 'AleTap01'),
(32, 'GimePro1'),
(33, 'Carla109'),
(34, 'FeliGo01'),
(35, 'MartuXD1'),
(36, 'EliStar1'),
(37, 'AndRol01'),
(38, 'RomiSo221'),
(39, 'Tincho911'),
(40, 'JimCool1'),
(41, 'AiluV123'),
(42, 'DiegoTi1'),
(43, 'CataBl01'),
(44, 'RamKl901'),
(45, 'LuisaMa1'),
(46, 'RodXxN01'),
(47, 'AgusZo01'),
(48, 'MarcWeb1'),
(49, 'Lucho271'),
(50, 'EugeRok1'),
(51, 'FlorA281'),
(52, 'Lucho271'),
(53, 'EugeRok1'),
(54, 'gabiram1'),
(55, 'EmiSky01'),
(56, 'FlorA281'),
(57, 'SantiXP1'),
(58, 'LeoKing1'),
(59, 'LucasZz1'),
(60, 'Fern0901')
go

insert into Reciben(IdMensaje, NomUsuDestino) values
(131, 'AleTap01'),
(131, 'GimePro1'),
(131, 'Pancho94'),
(132, 'Carla109'),
(132, 'FeliGo01'),
(132, 'Juan2025'),
(133, 'MartuXD1'),
(133, 'EliStar1'),
(133, 'Rodri123'),
(134, 'AndRol01'),
(134, 'RomiSo221'),
(134, 'Sabrina34'),
(135, 'Tincho911'),
(135, 'JimCool1'),
(135, 'ProGamer'),
(136, 'DiegoTi1'),
(136, 'CamCool1'),
(136, 'AiluV123'),
(137, 'CataBl01'),
(137, 'RamKl901'),
(137, 'Nacho061'),
(138, 'LuisaMa1'),
(138, 'RodXxN01'),
(138, 'gaturro12'),
(139, 'AgusZo01'),
(139, 'MarcWeb1'),
(139, 'UsuDam24'),
(140, 'Lucho271'),
(140, 'EugeRok1'),
(140, 'gabiram1'),
(141, 'FlorA281'),
(141, 'SantiXP1'),
(141, 'LeoKing1'),
(142, 'DaniKr01'),
(142, 'EstebMa1'),
(142, 'Valen071'),
(143, 'CamCool1'),
(143, 'FranO991'),
(143, 'TomyPlay'),
(144, 'NatyRi01'),
(144, 'CrisTe01'),
(144, 'AniSun90'),
(145, 'MeliLov1'),
(145, 'TeoGame1'),
(145, 'Charly25'),
(146, 'RomiPink1'),
(146, 'Josema01'),
(146, 'Fern0901'),
(147, 'IvanaC01'),
(147, 'LauPow01'),
(147, 'MicaBr01'),
(148, 'EmiSky01'),
(148, 'LucasZz1'),
(148, 'GonzaWeb'),
(149, 'BrenRod1'),
(149, 'NicosXD1'),
(149, 'LuLu7777'),
(150, 'FioOnl11'),
(150, 'MaxiDev1'),
(150, 'PatoXx12'),
(171, 'FlorA281'),
(171, 'SantiXP1'),
(171, 'LeoKing1'),
(172, 'DaniKr01'),
(172, 'EstebMa1'),
(172, 'Valen071'),
(173, 'CamCool1'),
(173, 'FranO991'),
(173, 'TomyPlay'),
(174, 'NatyRi01'),
(174, 'CrisTe01'),
(174, 'AniSun90'),
(175, 'MeliLov1'),
(175, 'TeoGame1'),
(175, 'Charly25'),
(176, 'RomiPink1'),
(176, 'Josema01'),
(176, 'Fern0901'),
(177, 'IvanaC01'),
(177, 'LauPow01'),
(177, 'MicaBr01'),
(178, 'EmiSky01'),
(178, 'LucasZz1'),
(178, 'GonzaWeb'),
(179, 'BrenRod1'),
(179, 'NicosXD1'),
(179, 'LuLu7777'),
(180, 'FioOnl11'),
(180, 'MaxiDev1'),
(180, 'PatoXx12')
go

insert into Reciben(IdMensaje, NomUsuDestino) values
(151, 'AleTap01'),
(151, 'GimePro1'),
(151, 'Pancho94'),
(151, 'FranO991'),
(152, 'Carla109'),
(152, 'FeliGo01'),
(152, 'Juan2025'),
(152, 'NatyRi01'),
(153, 'MartuXD1'),
(153, 'EliStar1'),
(153, 'Rodri123'),
(153, 'CrisTe01'),
(154, 'AndRol01'),
(154, 'RomiSo221'),
(154, 'Sabrina34'),
(154, 'MeliLov1'),
(155, 'Tincho911'),
(155, 'JimCool1'),
(155, 'ProGamer'),
(155, 'TeoGame1'),
(156, 'DiegoTi1'),
(156, 'CamCool1'),
(156, 'AiluV123'),
(156, 'RomiPink1'),
(157, 'CataBl01'),
(157, 'RamKl901'),
(157, 'Nacho061'),
(157, 'Josema01'),
(158, 'LuisaMa1'),
(158, 'RodXxN01'),
(158, 'gaturro12'),
(158, 'IvanaC01'),
(159, 'AgusZo01'),
(159, 'MarcWeb1'),
(159, 'UsuDam24'),
(159, 'LauPow01'),
(160, 'Lucho271'),
(160, 'EugeRok1'),
(160, 'gabiram1'),
(160, 'EmiSky01'),
(161, 'FlorA281'),
(161, 'SantiXP1'),
(161, 'LeoKing1'),
(161, 'LucasZz1'),
(161, 'Fern0901'),
(162, 'DaniKr01'),
(162, 'EstebMa1'),
(162, 'Valen071'),
(162, 'BrenRod1'),
(162, 'Charly25'),
(163, 'CamCool1'),
(163, 'FranO991'),
(163, 'TomyPlay'),
(163, 'NicosXD1'),
(163, 'AniSun90'),
(164, 'NatyRi01'),
(164, 'CrisTe01'),
(164, 'AniSun90'),
(164, 'FioOnl11'),
(164, 'TomyPlay'),
(165, 'MeliLov1'),
(165, 'TeoGame1'),
(165, 'Charly25'),
(165, 'MaxiDev1'),
(165, 'Valen071'),
(166, 'RomiPink1'),
(166, 'Josema01'),
(166, 'Fern0901'),
(166, 'SofiGm01'),
(166, 'LeoKing1'),
(167, 'IvanaC01'),
(167, 'LauPow01'),
(167, 'MicaBr01'),
(167, 'PatoXx12'),
(167, 'Sabrina34'),
(168, 'EmiSky01'),
(168, 'LucasZz1'),
(168, 'GonzaWeb'),
(168, 'LuLu7777'),
(168, 'Rodri123'),
(169, 'BrenRod1'),
(169, 'NicosXD1'),
(169, 'LuLu7777'),
(169, 'GonzaWeb'),
(169, 'gabiram1'),
(170, 'FioOnl11'),
(170, 'MaxiDev1'),
(170, 'PatoXx12'),
(170, 'MicaBr01'),
(170, 'gaturro12')
go


insert into Reciben(IdMensaje, NomUsuDestino) values
(181, 'LeoKing1'),
(182, 'Rodri123'),
(183, 'Rodri123'),
(184, 'Sabrina34'),
(185, 'LeoKing1'),
(186, 'Valen071'),
(187, 'TomyPlay'),
(188, 'AniSun90'),
(189, 'Charly25'),
(190, 'Fern0901'),
(191, 'MicaBr01'),
(192, 'GonzaWeb'),
(193, 'LuLu7777'),
(194, 'PatoXx12'),
(195, 'SofiGm01'),
(196, 'MaxiDev1'),
(197, 'FioOnl11'),
(198, 'NicosXD1'),
(199, 'BrenRod1'),
(200, 'LucasZz1')
go

insert into Reciben(IdMensaje, NomUsuDestino) values
(1, 'AleTap01'),
(2, 'GimePro1'),
(3, 'Carla109'),
(4, 'FeliGo01'),
(5, 'MartuXD1'),
(6, 'EliStar1'),
(7, 'AndRol01'),
(8, 'RomiSo221'),
(9, 'Tincho911'),
(10, 'JimCool1'),
(11, 'AiluV123'),
(12, 'DiegoTi1'),
(13, 'CataBl01'),
(14, 'RamKl901'),
(15, 'LuisaMa1'),
(16, 'RodXxN01'),
(17, 'AgusZo01'),
(18, 'MarcWeb1'),
(19, 'Lucho271'),
(20, 'EugeRok1'),
(21, 'AiluV123'),
(22, 'DiegoTi1'),
(23, 'CataBl01'),
(24, 'RamKl901'),
(25, 'LuisaMa1'),
(26, 'RodXxN01'),
(27, 'AgusZo01'),
(28, 'MarcWeb1'),
(29, 'Lucho271'),
(30, 'EugeRok1')
go



Create PROCEDURE AltaUsuario
    @NomUsu VARCHAR(20),
    @ContraUsu VARCHAR(8),
    @NomComUsu VARCHAR(50),
    @FechaNacUsu DATE,
    @EmailUsu VARCHAR(100)
AS
BEGIN

		if (exists (Select * From Usuarios Where NomUsu = @NomUsu and UsuarioActivo = 1))
		begin
			return -1
		end

		if (exists (Select * From Usuarios where NomUsu = @NomUsu and UsuarioActivo = 0))
		Begin
			Update Usuarios
			set ContraUsu = @ContraUsu, NomComUsu = @NomComUsu, FechaNacUsu = @FechaNacUsu, EmailUsu = @EmailUsu, UsuarioActivo = 1
			Where NomUsu = @NomUsu
			return 1
		end

		Insert Usuarios (NomUsu, ContraUsu, NomComUsu, FechaNacUsu, EmailUsu)
		values (@NomUsu, @ContraUsu, @NomComUsu, @FechaNacUsu, @EmailUsu)
		return 2
End
Go

CREATE PROCEDURE BajaUsuario
    @NomUsu VARCHAR(20)
AS
BEGIN
		if not exists(select * from Usuarios Where NomUsu = @NomUsu)
			begin
				return -1
			end

		if exists(select * from Mensajes where UsuarioEmisor = @NomUsu)
			begin
				Update Usuarios
				Set UsuarioActivo = 0 
				where NomUsu = @NomUsu 

				return 1
			end

		if exists(select * from Reciben where NomUsuDestino = @NomUsu)
			Begin
				Update Usuarios
				Set UsuarioActivo = 0 
				where NomUsu = @NomUsu 

				return 2
			end

			Delete from Usuarios where NomUsu = @NomUsu
			if (@@error = 0)
				return 3
			Else
				return -2
		
END
GO

Create PROCEDURE ModificarContrasenia
    @NomUsu VARCHAR(20),
    @NuevaContra VARCHAR(8)
AS
BEGIN
    if not exists(Select * From Usuarios where NomUsu = @NomUsu and UsuarioActivo = 1)
		return -1 

	Update Usuarios
	Set ContraUsu =  @NuevaContra where NomUsu = @NomUsu
END
GO

Create Procedure LogueoUsuario
@NomUsuario varchar(20),
@Contrasena varchar(8)
As
Begin
	Select * From Usuarios
	Where NomUsu = @NomUsuario and ContraUsu = @Contrasena and UsuarioActivo = 1
End
Go

Create Procedure BuscarUsuActivos @NomUsu varchar(20) as
Begin
	select * From Usuarios
	Where NomUsu = @NomUsu and UsuarioActivo = 1
end
go

Create Procedure BuscarUsuarios @NomUsu varchar(20) as
Begin
	Select * From Usuarios
	Where NomUsu = @NomUsu
end
go


Create Procedure ListarUsuariosActivos
as
begin
	select * from Usuarios
	where UsuarioActivo = 1
end
go


Create Procedure AltaMensajeComun
@asunto varchar(100),
@texto varchar(1000),
@codigoCat varchar(3),
@usuarioEnvia varchar(20)
As
Begin

	if not exists(select * from Categorias where CodigoCat = @codigoCat)
		begin
			return -1
		end

	if not exists(select * from Usuarios where NomUsu = @usuarioEnvia and UsuarioActivo = 1)
		begin
			return -2
		end
		
	insert Mensajes (Asunto, Texto, UsuarioEmisor) values (@asunto, @texto, @usuarioEnvia)
			
	Declare @IdMensaje int = Scope_Identity()
			
	insert Comunes (IdMensaje, CodigoCategoria) values (@IdMensaje, @codigoCat)
	if @@ERROR = 0
		return @IdMensaje

	else
		return 0
			
End
Go

Create PROCEDURE ListarMensajesComunes
AS
BEGIN
    SELECT C.IdMensaje, C.CodigoCategoria, M.Asunto, M.Texto, U.NomUsu, M.FechaHoraEnvio
    FROM Comunes C
    INNER JOIN Mensajes M ON M.IdMensaje = C.IdMensaje
	INNER JOIN Usuarios U ON M.UsuarioEmisor = U.NomUsu
END
GO


Create Procedure ListarMensajesComunesEnviados @nomUsu varchar(20) as
begin
	select M.IdMensaje, M.Asunto, M.Texto, M.FechaHoraEnvio, U.NomUsu,C.CodigoCategoria 
	From Mensajes M inner join Comunes C on  M.IdMensaje = C.IdMensaje
	INNER JOIN Usuarios U ON M.UsuarioEmisor = U.NomUsu
	where M.UsuarioEmisor = @nomUsu
end
go

create Procedure ListarMensajesComunesRecibidos @nomUsu varchar(20) as
begin
	Select M.IdMensaje, M.Asunto, M.Texto, M.FechaHoraEnvio, U.NomUsu, C.CodigoCategoria From Mensajes M inner join Comunes C on M.IdMensaje = C.IdMensaje
	inner join Reciben D on M.IdMensaje = D.IdMensaje
	INNER JOIN Usuarios U ON M.UsuarioEmisor = U.NomUsu
	where D.NomUsuDestino = @nomUsu
end
go	

Create Procedure AltaMensajePrivado
@asunto varchar(100),
@texto varchar(1000),
@fechaCaducidad datetime,
@usuarioEnvia varchar(20)
as
begin

	if not exists(select * from Usuarios where NomUsu = @usuarioEnvia and UsuarioActivo = 1)
		begin
			return -1
		end
		
	insert Mensajes (Asunto, Texto, UsuarioEmisor) values (@asunto, @texto, @usuarioEnvia)
			
	Declare @IdMensaje int = Scope_Identity()
			
	insert Privados (IdMensaje, FechaCaducidad) values (@IdMensaje, @fechaCaducidad)
	if @@ERROR = 0
		return @IdMensaje

	else
		return 0
end
go

Create Procedure ListarMensajesPrivados as
Begin
	Select P.IdMensaje, P.FechaCaducidad, M.Asunto, M.Texto,  U.NomUsu, M.FechaHoraEnvio
	From Privados P inner join Mensajes M on M.IdMensaje = P.IdMensaje
	INNER JOIN Usuarios U ON M.UsuarioEmisor = U.NomUsu
end
go


Create Procedure ListarMensajesPrivadosEnviados @nomUsu varchar(20) as
begin
	select M.IdMensaje, M.Asunto, M.Texto, M.FechaHoraEnvio, U.NomUsu, P.FechaCaducidad 
	From Mensajes M inner join Privados P on M.IdMensaje = P.IdMensaje
	INNER JOIN Usuarios U ON M.UsuarioEmisor = U.NomUsu
	where M.UsuarioEmisor = @nomUsu
end
go


Create Procedure ListarMensajesPrivadosRecibidos @nomUsu varchar(20) as
begin
	Select M.IdMensaje, M.Asunto, M.Texto, M.FechaHoraEnvio, U.NomUsu,P.FechaCaducidad From Mensajes M inner join Privados P on M.IdMensaje = P.IdMensaje
	inner join Reciben D on M.IdMensaje = D.IdMensaje
	INNER JOIN Usuarios U ON M.UsuarioEmisor = U.NomUsu
	where D.NomUsuDestino = @nomUsu and P.FechaCaducidad > GETDATE()
end
go

Create Procedure AltaMensajeRecordatorio
@asunto varchar(100),
@texto varchar(1000),
@tipoRecordatorio varchar(10),
@usuarioEnvia varchar(20)
as
begin

	if not exists(select * from Usuarios where NomUsu = @usuarioEnvia and UsuarioActivo = 1)
		begin
			return -1
		end
		
	insert Mensajes (Asunto, Texto, UsuarioEmisor) values (@asunto, @texto, @usuarioEnvia)
			
	Declare @IdMensaje int = Scope_Identity()
			
	insert Recordatorios(IdMensaje, TipoRecordatorio) values (@IdMensaje, @tipoRecordatorio)
	if @@ERROR = 0
		return @IdMensaje

	else
		return 0
end
go

Create Procedure ListarMensajesRecordatorios as
Begin
	Select R.*, M.Asunto, M.Texto, U.NomUsu, M.FechaHoraEnvio
	From Recordatorios R inner join Mensajes M on M.IdMensaje = R.IdMensaje
	INNER JOIN Usuarios U ON M.UsuarioEmisor = U.NomUsu
end
go

Create Procedure ListarMensajesRecordatoriosEnviados @nomUsu varchar(20) as
begin
	select M.IdMensaje, M.Asunto, M.Texto, M.FechaHoraEnvio, U.NomUsu, R.TipoRecordatorio 
	From Mensajes M inner join Recordatorios R on  M.IdMensaje = R.IdMensaje
	INNER JOIN Usuarios U ON M.UsuarioEmisor = U.NomUsu
	where M.UsuarioEmisor = @nomUsu
end
go

Create Procedure ListarMensajesRecordatoriosRecibidos @nomUsu varchar(20) as
begin
	Select M.IdMensaje, M.Asunto, M.Texto, M.FechaHoraEnvio, U.NomUsu,R.TipoRecordatorio From Mensajes M inner join Recordatorios R on M.IdMensaje = R.IdMensaje
	inner join Reciben D on M.IdMensaje = D.IdMensaje
	INNER JOIN Usuarios U ON M.UsuarioEmisor = U.NomUsu
	where D.NomUsuDestino = @nomUsu
end
go


Create Procedure AltaUsuarioReciben @idMensaje int, @nomUsuReciben varchar(20) as
Begin

	if not exists(select * from Usuarios where NomUsu = @nomUsuReciben and UsuarioActivo = 1)
		return -1

	if not exists(select * from Mensajes where IdMensaje = @idMensaje)
		return -2

	if exists(select * From Reciben where IdMensaje = @idMensaje and NomUsuDestino = @nomUsuReciben)
		return -3

	insert Reciben (IdMensaje, NomUsuDestino) values (@idMensaje, @nomUsuReciben)

	if @@ERROR = 0
		return 1
	else
		return 0
end
go


create Procedure UsuarioReciben @idMensaje int as
begin
	select U.NomUsu, U.ContraUsu, U.NomComUsu, U.EmailUsu, U.FechaNacUsu
    from Reciben R
    inner join Usuarios U on R.NomUsuDestino = U.NomUsu
    where R.IdMensaje = @idMensaje
end
go


Create Procedure BuscarCategorias @codigoCat varchar(3) as
Begin
	Select * From Categorias
	Where CodigoCat = @codigoCat
end
go

Create Procedure ListarCategorias
as
begin
	Select * From Categorias
end
go
