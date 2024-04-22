create or replace view aggJoin4992056164815559238 as (
with aggView3706667653855219070 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView3706667653855219070 where cc.subject_id=aggView3706667653855219070.v5);
create or replace view aggJoin5598498665376103120 as (
with aggView8305019904021886556 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView8305019904021886556 where ci.person_id=aggView8305019904021886556.v31);
create or replace view aggJoin5680213261194183885 as (
with aggView4960501960208611392 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin4992056164815559238 join aggView4960501960208611392 using(v7));
create or replace view aggJoin1763034684366782336 as (
with aggView2331227712025712006 as (select v40 from aggJoin5680213261194183885 group by v40)
select id as v40, title as v41, kind_id as v26, production_year as v44 from title as t, aggView2331227712025712006 where t.id=aggView2331227712025712006.v40 and production_year>1950);
create or replace view aggJoin1757032948819442980 as (
with aggView998080727350395507 as (select id as v26 from kind_type as kt where kind= 'movie')
select v40, v41, v44 from aggJoin1763034684366782336 join aggView998080727350395507 using(v26));
create or replace view aggJoin3863079696919435930 as (
with aggView5845703961280701563 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin5598498665376103120 join aggView5845703961280701563 using(v9));
create or replace view aggJoin3819993551439928236 as (
with aggView1310744949939727083 as (select v40 from aggJoin3863079696919435930 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView1310744949939727083 where mk.movie_id=aggView1310744949939727083.v40);
create or replace view aggJoin8002099627990016839 as (
with aggView154070591982731682 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin3819993551439928236 join aggView154070591982731682 using(v23));
create or replace view aggJoin40704866520826026 as (
with aggView3561546843375369921 as (select v40 from aggJoin8002099627990016839 group by v40)
select v41, v44 from aggJoin1757032948819442980 join aggView3561546843375369921 using(v40));
create or replace view aggView5344264722164777199 as select v41 from aggJoin40704866520826026 group by v41;
select MIN(v41) as v52 from aggView5344264722164777199;
