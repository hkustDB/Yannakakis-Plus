create or replace view aggView5046219745523958294 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin755024662981779187 as (
with aggView7794545707111578359 as (select title as v38, id as v37 from title as t where production_year>2010)
select v37, v38 from aggView7794545707111578359 where v38 LIKE 'Vampire%');
create or replace view aggJoin4585852034578614538 as (
with aggView6220378561750090402 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView6220378561750090402 where mi.info_type_id=aggView6220378561750090402.v8 and info= 'Horror');
create or replace view aggView1041400489384368443 as select v18, v37 from aggJoin4585852034578614538 group by v18,v37;
create or replace view aggJoin8664820203839895720 as (
with aggView6220783305987908971 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView6220783305987908971 where mi_idx.info_type_id=aggView6220783305987908971.v10);
create or replace view aggView8956987812432965817 as select v23, v37 from aggJoin8664820203839895720 group by v23,v37;
create or replace view aggJoin1638491405118000976 as (
with aggView5400654597408076960 as (select v37, MIN(v18) as v49 from aggView1041400489384368443 group by v37)
select v23, v37, v49 from aggView8956987812432965817 join aggView5400654597408076960 using(v37));
create or replace view aggJoin5181903659356743393 as (
with aggView4118017551574510006 as (select v37, MIN(v49) as v49, MIN(v23) as v50 from aggJoin1638491405118000976 group by v37,v49)
select v37, v38, v49, v50 from aggJoin755024662981779187 join aggView4118017551574510006 using(v37));
create or replace view aggJoin1472253880059706895 as (
with aggView8713262623621449037 as (select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v38) as v52 from aggJoin5181903659356743393 group by v37,v50,v49)
select person_id as v28, movie_id as v37, note as v5, v49, v50, v52 from cast_info as ci, aggView8713262623621449037 where ci.movie_id=aggView8713262623621449037.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin9218077240387746630 as (
with aggView3114982985405731451 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView3114982985405731451 where mk.keyword_id=aggView3114982985405731451.v12);
create or replace view aggJoin8286817461703919669 as (
with aggView1785012481093522689 as (select v37 from aggJoin9218077240387746630 group by v37)
select v28, v5, v49 as v49, v50 as v50, v52 as v52 from aggJoin1472253880059706895 join aggView1785012481093522689 using(v37));
create or replace view aggJoin897647551661490874 as (
with aggView7724870470075353502 as (select v28, MIN(v49) as v49, MIN(v50) as v50, MIN(v52) as v52 from aggJoin8286817461703919669 group by v28,v50,v52,v49)
select v29, v49, v50, v52 from aggView5046219745523958294 join aggView7724870470075353502 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin897647551661490874;
