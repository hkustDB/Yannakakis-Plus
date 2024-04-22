create or replace view aggJoin7886833349131905322 as (
with aggView7726764055093112009 as (select id as v26, name as v47 from name as n where name LIKE 'X%')
select movie_id as v3, v47 from cast_info as ci, aggView7726764055093112009 where ci.person_id=aggView7726764055093112009.v26);
create or replace view aggJoin7050386575311313665 as (
with aggView1144158394678174814 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView1144158394678174814 where mk.keyword_id=aggView1144158394678174814.v25);
create or replace view aggJoin2343194873046654965 as (
with aggView8940147105426912427 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8940147105426912427 where mc.company_id=aggView8940147105426912427.v20);
create or replace view aggJoin3698449677215153500 as (
with aggView2380785294058875280 as (select v3 from aggJoin2343194873046654965 group by v3)
select id as v3 from title as t, aggView2380785294058875280 where t.id=aggView2380785294058875280.v3);
create or replace view aggJoin2161598268135153310 as (
with aggView8914426359205105918 as (select v3 from aggJoin7050386575311313665 group by v3)
select v3 from aggJoin3698449677215153500 join aggView8914426359205105918 using(v3));
create or replace view aggJoin7707976486611104539 as (
with aggView1932763547043680364 as (select v3 from aggJoin2161598268135153310 group by v3)
select v47 as v47 from aggJoin7886833349131905322 join aggView1932763547043680364 using(v3));
select MIN(v47) as v47 from aggJoin7707976486611104539;
