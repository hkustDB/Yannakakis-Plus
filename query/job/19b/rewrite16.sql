create or replace view aggJoin7624296524172769339 as (
with aggView1657370091164892576 as (select id as v42, name as v43 from name as n where gender= 'f')
select v42, v43 from aggView1657370091164892576 where v43 LIKE '%Angel%');
create or replace view aggJoin153846700402759072 as (
with aggView3464553926523400989 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView3464553926523400989 where mc.company_id=aggView3464553926523400989.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin6481280694998439133 as (
with aggView5515878065985391516 as (select v53 from aggJoin153846700402759072 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView5515878065985391516 where t.id=aggView5515878065985391516.v53 and production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%');
create or replace view aggView6829962077682546800 as select v54, v53 from aggJoin6481280694998439133 group by v54,v53;
create or replace view aggJoin7848103899123754443 as (
with aggView4669429255187048339 as (select v53, MIN(v54) as v66 from aggView6829962077682546800 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView4669429255187048339 where ci.movie_id=aggView4669429255187048339.v53 and note= '(voice)');
create or replace view aggJoin86413548570265545 as (
with aggView996392836791146541 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v53, v9, v20, v51, v66 as v66 from aggJoin7848103899123754443 join aggView996392836791146541 using(v42));
create or replace view aggJoin7123744438860752542 as (
with aggView6018264045464445031 as (select id as v9 from char_name as chn)
select v42, v53, v20, v51, v66 from aggJoin86413548570265545 join aggView6018264045464445031 using(v9));
create or replace view aggJoin8620031617130381539 as (
with aggView8975889629773807762 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v20, v66 from aggJoin7123744438860752542 join aggView8975889629773807762 using(v51));
create or replace view aggJoin2867706548696842285 as (
with aggView7425618244845461776 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView7425618244845461776 where mi.info_type_id=aggView7425618244845461776.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin6190585500627465468 as (
with aggView6930875000112683724 as (select v53 from aggJoin2867706548696842285 group by v53)
select v42, v20, v66 as v66 from aggJoin8620031617130381539 join aggView6930875000112683724 using(v53));
create or replace view aggJoin589078070247478601 as (
with aggView4675434584035456419 as (select v42, MIN(v66) as v66 from aggJoin6190585500627465468 group by v42,v66)
select v43, v66 from aggJoin7624296524172769339 join aggView4675434584035456419 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin589078070247478601;
