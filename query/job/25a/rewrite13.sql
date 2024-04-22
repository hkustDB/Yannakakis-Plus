create or replace view aggJoin3370014489893883339 as (
with aggView690080857231118984 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView690080857231118984 where ci.person_id=aggView690080857231118984.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4471169409055330628 as (
with aggView6376433493807501881 as (select id as v37, title as v52 from title as t)
select v37, v5, v51, v52 from aggJoin3370014489893883339 join aggView6376433493807501881 using(v37));
create or replace view aggJoin1548732499610255702 as (
with aggView1281575006884627134 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView1281575006884627134 where mi_idx.info_type_id=aggView1281575006884627134.v10);
create or replace view aggJoin392475362463848706 as (
with aggView3017542234277307550 as (select v37, MIN(v23) as v50 from aggJoin1548732499610255702 group by v37)
select movie_id as v37, info_type_id as v8, info as v18, v50 from movie_info as mi, aggView3017542234277307550 where mi.movie_id=aggView3017542234277307550.v37 and info= 'Horror');
create or replace view aggJoin4994099770795407426 as (
with aggView887338424512292422 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView887338424512292422 where mk.keyword_id=aggView887338424512292422.v12);
create or replace view aggJoin192596358824141751 as (
with aggView9142559286779649018 as (select id as v8 from info_type as it1 where info= 'genres')
select v37, v18, v50 from aggJoin392475362463848706 join aggView9142559286779649018 using(v8));
create or replace view aggJoin8374678264278708788 as (
with aggView6185222060442902977 as (select v37, MIN(v50) as v50, MIN(v18) as v49 from aggJoin192596358824141751 group by v37,v50)
select v37, v5, v51 as v51, v52 as v52, v50, v49 from aggJoin4471169409055330628 join aggView6185222060442902977 using(v37));
create or replace view aggJoin1237281973102858329 as (
with aggView4174651924546685911 as (select v37, MIN(v51) as v51, MIN(v52) as v52, MIN(v50) as v50, MIN(v49) as v49 from aggJoin8374678264278708788 group by v37,v51,v49,v50,v52)
select v51, v52, v50, v49 from aggJoin4994099770795407426 join aggView4174651924546685911 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin1237281973102858329;
