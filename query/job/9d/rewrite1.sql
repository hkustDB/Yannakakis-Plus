create or replace view aggView3533722194691096093 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView2889851152549684665 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView4581647212894316814 as select name as v36, id as v35 from name as n where gender= 'f';
create or replace view aggJoin164100803228890512 as (
with aggView2923890310915122218 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView2923890310915122218 where mc.company_id=aggView2923890310915122218.v32);
create or replace view aggJoin495576425212720722 as (
with aggView8707101854592154670 as (select v18 from aggJoin164100803228890512 group by v18)
select id as v18, title as v47 from title as t, aggView8707101854592154670 where t.id=aggView8707101854592154670.v18);
create or replace view aggView1046545814910306477 as select v18, v47 from aggJoin495576425212720722 group by v18,v47;
create or replace view aggJoin1306432372510892589 as (
with aggView6863595774504236160 as (select v9, MIN(v10) as v59 from aggView2889851152549684665 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView6863595774504236160 where ci.person_role_id=aggView6863595774504236160.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5446504041778102570 as (
with aggView3696161617440741314 as (select v18, MIN(v47) as v61 from aggView1046545814910306477 group by v18)
select v35, v20, v22, v59 as v59, v61 from aggJoin1306432372510892589 join aggView3696161617440741314 using(v18));
create or replace view aggJoin4723614800639451043 as (
with aggView5941409222877135080 as (select v35, MIN(v36) as v60 from aggView4581647212894316814 group by v35)
select v35, v3, v60 from aggView3533722194691096093 join aggView5941409222877135080 using(v35));
create or replace view aggJoin4828618374873143900 as (
with aggView4157227441819789454 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v59, v61 from aggJoin5446504041778102570 join aggView4157227441819789454 using(v22));
create or replace view aggJoin8949401996386062526 as (
with aggView4695494462796949237 as (select v35, MIN(v59) as v59, MIN(v61) as v61 from aggJoin4828618374873143900 group by v35,v59,v61)
select v3, v60 as v60, v59, v61 from aggJoin4723614800639451043 join aggView4695494462796949237 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin8949401996386062526;
