create or replace view aggView1869125039547801365 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggView5059163000831031160 as select title as v38, id as v37 from title as t;
create or replace view aggJoin6341443556368973534 as (
with aggView3084579813974400995 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView3084579813974400995 where mi_idx.info_type_id=aggView3084579813974400995.v10);
create or replace view aggView5870058558097325082 as select v23, v37 from aggJoin6341443556368973534 group by v23,v37;
create or replace view aggJoin521417875684214210 as (
with aggView1775819041034852432 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView1775819041034852432 where mi.info_type_id=aggView1775819041034852432.v8);
create or replace view aggJoin5630254921367967705 as (
with aggView1614617346064757466 as (select v18, v37 from aggJoin521417875684214210 group by v18,v37)
select v37, v18 from aggView1614617346064757466 where v18= 'Horror');
create or replace view aggJoin2342252483776786838 as (
with aggView6422460267132717478 as (select v28, MIN(v29) as v51 from aggView1869125039547801365 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView6422460267132717478 where ci.person_id=aggView6422460267132717478.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8378852555065510136 as (
with aggView156533973938299493 as (select v37, MIN(v38) as v52 from aggView5059163000831031160 group by v37)
select v23, v37, v52 from aggView5870058558097325082 join aggView156533973938299493 using(v37));
create or replace view aggJoin6670571765254292214 as (
with aggView8701970826176687455 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView8701970826176687455 where mk.keyword_id=aggView8701970826176687455.v12);
create or replace view aggJoin3955477837583502669 as (
with aggView3677792525237053802 as (select v37 from aggJoin6670571765254292214 group by v37)
select v37, v5, v51 as v51 from aggJoin2342252483776786838 join aggView3677792525237053802 using(v37));
create or replace view aggJoin4790072172135935258 as (
with aggView7358978556951884443 as (select v37, MIN(v51) as v51 from aggJoin3955477837583502669 group by v37,v51)
select v23, v37, v52 as v52, v51 from aggJoin8378852555065510136 join aggView7358978556951884443 using(v37));
create or replace view aggJoin1919247282799387529 as (
with aggView4447157702569573534 as (select v37, MIN(v52) as v52, MIN(v51) as v51, MIN(v23) as v50 from aggJoin4790072172135935258 group by v37,v51,v52)
select v18, v52, v51, v50 from aggJoin5630254921367967705 join aggView4447157702569573534 using(v37));
select MIN(v18) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin1919247282799387529;
