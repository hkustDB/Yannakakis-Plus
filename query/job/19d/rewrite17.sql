create or replace view aggView6487122776226795303 as select id as v42, name as v43 from name as n where gender= 'f';
create or replace view aggView7170678371538807813 as select id as v53, title as v54 from title as t where production_year>2000;
create or replace view aggJoin5976579593190494722 as (
with aggView8852576227861034271 as (select v42, MIN(v43) as v65 from aggView6487122776226795303 group by v42)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView8852576227861034271 where ci.person_id=aggView8852576227861034271.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3244462415100103134 as (
with aggView7862094323390233378 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin5976579593190494722 join aggView7862094323390233378 using(v42));
create or replace view aggJoin7727352412128197400 as (
with aggView14843121061304787 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView14843121061304787 where mi.info_type_id=aggView14843121061304787.v30);
create or replace view aggJoin4620161988095379409 as (
with aggView1469065886639563044 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView1469065886639563044 where mc.company_id=aggView1469065886639563044.v23);
create or replace view aggJoin264162299888014570 as (
with aggView7398649724564377087 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin3244462415100103134 join aggView7398649724564377087 using(v51));
create or replace view aggJoin5377529473740611692 as (
with aggView5167375570031256411 as (select v53 from aggJoin7727352412128197400 group by v53)
select v53 from aggJoin4620161988095379409 join aggView5167375570031256411 using(v53));
create or replace view aggJoin9013833321451774562 as (
with aggView5556622540186896467 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin264162299888014570 join aggView5556622540186896467 using(v9));
create or replace view aggJoin4851496246043528534 as (
with aggView2730376220369598700 as (select v53 from aggJoin5377529473740611692 group by v53)
select v53, v20, v65 as v65 from aggJoin9013833321451774562 join aggView2730376220369598700 using(v53));
create or replace view aggJoin2103329799228440548 as (
with aggView7008567708252712631 as (select v53, MIN(v65) as v65 from aggJoin4851496246043528534 group by v53,v65)
select v54, v65 from aggView7170678371538807813 join aggView7008567708252712631 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin2103329799228440548;
