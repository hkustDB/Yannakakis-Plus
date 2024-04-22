create or replace view aggJoin7162069301015068431 as (
with aggView9115102230450416880 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView9115102230450416880 where mc.company_id=aggView9115102230450416880.v20);
create or replace view aggJoin8044067721961714249 as (
with aggView1095232864894673858 as (select v3 from aggJoin7162069301015068431 group by v3)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView1095232864894673858 where mk.movie_id=aggView1095232864894673858.v3);
create or replace view aggJoin1806473505627778943 as (
with aggView834774248377350069 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin8044067721961714249 join aggView834774248377350069 using(v25));
create or replace view aggJoin4783095925838346461 as (
with aggView2199202852848484230 as (select v3 from aggJoin1806473505627778943 group by v3)
select id as v3 from title as t, aggView2199202852848484230 where t.id=aggView2199202852848484230.v3);
create or replace view aggJoin5080306797720469478 as (
with aggView3125440102936975396 as (select v3 from aggJoin4783095925838346461 group by v3)
select person_id as v26 from cast_info as ci, aggView3125440102936975396 where ci.movie_id=aggView3125440102936975396.v3);
create or replace view aggJoin4437451872496930991 as (
with aggView7234138948518475171 as (select v26 from aggJoin5080306797720469478 group by v26)
select name as v27 from name as n, aggView7234138948518475171 where n.id=aggView7234138948518475171.v26);
create or replace view aggJoin3418137523347232345 as (
with aggView3378142212598850931 as (select v27 from aggJoin4437451872496930991 group by v27)
select v27 from aggView3378142212598850931 where v27 LIKE 'B%');
select MIN(v27) as v47 from aggJoin3418137523347232345;
