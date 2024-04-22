create or replace view aggView6629006545955258851 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin807659241887755522 as (
with aggView4310924253589165753 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4310924253589165753 where t.kind_id=aggView4310924253589165753.v28 and production_year>2005);
create or replace view aggView4779500100571781696 as select v47, v48 from aggJoin807659241887755522 group by v47,v48;
create or replace view aggJoin426586220122466690 as (
with aggView6861203137437545342 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView6861203137437545342 where mi_idx.info_type_id=aggView6861203137437545342.v23);
create or replace view aggJoin7433593702484082713 as (
with aggView3136649942402590146 as (select v47, v33 from aggJoin426586220122466690 group by v47,v33)
select v47, v33 from aggView3136649942402590146 where v33>'8.0');
create or replace view aggJoin7013622778279622438 as (
with aggView7884216877976058966 as (select v47, MIN(v33) as v60 from aggJoin7433593702484082713 group by v47)
select person_id as v38, movie_id as v47, person_role_id as v9, v60 from cast_info as ci, aggView7884216877976058966 where ci.movie_id=aggView7884216877976058966.v47);
create or replace view aggJoin3562554128151632292 as (
with aggView7529035413688345294 as (select v9, MIN(v10) as v59 from aggView6629006545955258851 group by v9)
select v38, v47, v60 as v60, v59 from aggJoin7013622778279622438 join aggView7529035413688345294 using(v9));
create or replace view aggJoin4647586074676964117 as (
with aggView5206144556808343447 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView5206144556808343447 where mk.keyword_id=aggView5206144556808343447.v25);
create or replace view aggJoin2782729329855818543 as (
with aggView5910228436515942685 as (select v47 from aggJoin4647586074676964117 group by v47)
select movie_id as v47, subject_id as v5, status_id as v7 from complete_cast as cc, aggView5910228436515942685 where cc.movie_id=aggView5910228436515942685.v47);
create or replace view aggJoin4231583891050402903 as (
with aggView8915260052891655511 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47, v5 from aggJoin2782729329855818543 join aggView8915260052891655511 using(v7));
create or replace view aggJoin2482280468957315823 as (
with aggView2596934081706536717 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin4231583891050402903 join aggView2596934081706536717 using(v5));
create or replace view aggJoin4688843011283674728 as (
with aggView6137202588950947914 as (select v47 from aggJoin2482280468957315823 group by v47)
select v38, v47, v60 as v60, v59 as v59 from aggJoin3562554128151632292 join aggView6137202588950947914 using(v47));
create or replace view aggJoin1912076003273705907 as (
with aggView4137818492643827791 as (select id as v38 from name as n)
select v47, v60, v59 from aggJoin4688843011283674728 join aggView4137818492643827791 using(v38));
create or replace view aggJoin1636259819206138157 as (
with aggView3590635606457732718 as (select v47, MIN(v60) as v60, MIN(v59) as v59 from aggJoin1912076003273705907 group by v47,v59,v60)
select v48, v60, v59 from aggView4779500100571781696 join aggView3590635606457732718 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v48) as v61 from aggJoin1636259819206138157;
