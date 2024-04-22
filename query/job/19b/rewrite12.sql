create or replace view aggJoin5535666034844990662 as (
with aggView8032624291614605677 as (select id as v53, title as v66 from title as t where production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%')
select movie_id as v53, company_id as v23, note as v36, v66 from movie_companies as mc, aggView8032624291614605677 where mc.movie_id=aggView8032624291614605677.v53 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin7134684920602296764 as (
with aggView2159017301531205786 as (select id as v42, name as v65 from name as n where gender= 'f' and name LIKE '%Angel%')
select person_id as v42, v65 from aka_name as an, aggView2159017301531205786 where an.person_id=aggView2159017301531205786.v42);
create or replace view aggJoin5778299184128720272 as (
with aggView8621236904105249069 as (select v42, MIN(v65) as v65 from aggJoin7134684920602296764 group by v42,v65)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView8621236904105249069 where ci.person_id=aggView8621236904105249069.v42 and note= '(voice)');
create or replace view aggJoin3704671719343685969 as (
with aggView2742110995062056180 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v36, v66 from aggJoin5535666034844990662 join aggView2742110995062056180 using(v23));
create or replace view aggJoin2825027808994743597 as (
with aggView1604541915780032065 as (select v53, MIN(v66) as v66 from aggJoin3704671719343685969 group by v53,v66)
select v53, v9, v20, v51, v65 as v65, v66 from aggJoin5778299184128720272 join aggView1604541915780032065 using(v53));
create or replace view aggJoin5488952282620628331 as (
with aggView8522276189991125699 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView8522276189991125699 where mi.info_type_id=aggView8522276189991125699.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin1848165597768448047 as (
with aggView1262953082705480423 as (select v53 from aggJoin5488952282620628331 group by v53)
select v9, v20, v51, v65 as v65, v66 as v66 from aggJoin2825027808994743597 join aggView1262953082705480423 using(v53));
create or replace view aggJoin5760570802804461172 as (
with aggView6982724952057801122 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin1848165597768448047 join aggView6982724952057801122 using(v51));
create or replace view aggJoin179388447303047082 as (
with aggView7672506027546643181 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin5760570802804461172 group by v9,v65,v66)
select v65, v66 from char_name as chn, aggView7672506027546643181 where chn.id=aggView7672506027546643181.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin179388447303047082;
