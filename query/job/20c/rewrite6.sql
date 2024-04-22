create or replace view aggView4966486549922744827 as select name as v32, id as v31 from name as n;
create or replace view aggJoin2615667917314516703 as (
with aggView1844972688864621783 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView1844972688864621783 where t.kind_id=aggView1844972688864621783.v26 and production_year>2000);
create or replace view aggView7453017546919574159 as select v40, v41 from aggJoin2615667917314516703 group by v40,v41;
create or replace view aggJoin8164389017018730380 as (
with aggView3844908507346442087 as (select v40, MIN(v41) as v53 from aggView7453017546919574159 group by v40)
select person_id as v31, movie_id as v40, person_role_id as v9, v53 from cast_info as ci, aggView3844908507346442087 where ci.movie_id=aggView3844908507346442087.v40);
create or replace view aggJoin4846074905128585850 as (
with aggView6227355748826786682 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v31, v40, v53 from aggJoin8164389017018730380 join aggView6227355748826786682 using(v9));
create or replace view aggJoin4824956540237531031 as (
with aggView8493938561512193236 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView8493938561512193236 where cc.status_id=aggView8493938561512193236.v7);
create or replace view aggJoin5173469113600104920 as (
with aggView9093405922184504660 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView9093405922184504660 where mk.keyword_id=aggView9093405922184504660.v23);
create or replace view aggJoin2100974027591342874 as (
with aggView2309702504650147948 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin4824956540237531031 join aggView2309702504650147948 using(v5));
create or replace view aggJoin4718061628436327067 as (
with aggView4015256647054124352 as (select v40 from aggJoin2100974027591342874 group by v40)
select v40 from aggJoin5173469113600104920 join aggView4015256647054124352 using(v40));
create or replace view aggJoin8571388932057846618 as (
with aggView5760442479923491501 as (select v40 from aggJoin4718061628436327067 group by v40)
select v31, v53 as v53 from aggJoin4846074905128585850 join aggView5760442479923491501 using(v40));
create or replace view aggJoin6292556650426746470 as (
with aggView8721567469312701650 as (select v31, MIN(v53) as v53 from aggJoin8571388932057846618 group by v31,v53)
select v32, v53 from aggView4966486549922744827 join aggView8721567469312701650 using(v31));
select MIN(v32) as v52,MIN(v53) as v53 from aggJoin6292556650426746470;
