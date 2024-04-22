create or replace view aggView7737564715533811530 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]';
create or replace view aggJoin8620928968856715193 as (
with aggView7136328149775982992 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView7136328149775982992 where mk.keyword_id=aggView7136328149775982992.v22);
create or replace view aggJoin7902216085708518024 as (
with aggView1792061308422328743 as (select v24 from aggJoin8620928968856715193 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView1792061308422328743 where ml.movie_id=aggView1792061308422328743.v24);
create or replace view aggJoin8041704935579575676 as (
with aggView1595554759578815589 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView1595554759578815589 where mc.company_type_id=aggView1595554759578815589.v18);
create or replace view aggView792781350419264622 as select v19, v24, v17 from aggJoin8041704935579575676 group by v19,v24,v17;
create or replace view aggJoin2869712388127214147 as (
with aggView6161023475572000572 as (select id as v13 from link_type as lt)
select v24 from aggJoin7902216085708518024 join aggView6161023475572000572 using(v13));
create or replace view aggJoin7031773958083102452 as (
with aggView2775119058098485135 as (select v24 from aggJoin2869712388127214147 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView2775119058098485135 where t.id=aggView2775119058098485135.v24 and production_year>1950);
create or replace view aggView740314948822986894 as select v24, v28 from aggJoin7031773958083102452 group by v24,v28;
create or replace view aggJoin2799305724361063651 as (
with aggView6081074837713893409 as (select v24, MIN(v28) as v41 from aggView740314948822986894 group by v24)
select v19, v17, v41 from aggView792781350419264622 join aggView6081074837713893409 using(v24));
create or replace view aggJoin3757998155740321539 as (
with aggView2464075167370998665 as (select v17, MIN(v41) as v41, MIN(v19) as v40 from aggJoin2799305724361063651 group by v17,v41)
select v2, v41, v40 from aggView7737564715533811530 join aggView2464075167370998665 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin3757998155740321539;
