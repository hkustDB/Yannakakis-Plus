create or replace view aggJoin4495910640132089711 as (
with aggView4546225713410561583 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView4546225713410561583 where t.kind_id=aggView4546225713410561583.v26 and production_year>2000);
create or replace view aggJoin8802418178198732288 as (
with aggView6736641062051098572 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView6736641062051098572 where ci.person_role_id=aggView6736641062051098572.v9);
create or replace view aggJoin5519506215047037102 as (
with aggView4832593519807787947 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin8802418178198732288 join aggView4832593519807787947 using(v31));
create or replace view aggJoin4677352561229533879 as (
with aggView4759710355488406754 as (select v40 from aggJoin5519506215047037102 group by v40)
select v40, v41, v44 from aggJoin4495910640132089711 join aggView4759710355488406754 using(v40));
create or replace view aggJoin4328237771525132715 as (
with aggView414668344575735467 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView414668344575735467 where cc.status_id=aggView414668344575735467.v7);
create or replace view aggJoin371473329608067507 as (
with aggView8584412548109622970 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin4328237771525132715 join aggView8584412548109622970 using(v5));
create or replace view aggJoin3415242973443699591 as (
with aggView8742527234425532782 as (select v40 from aggJoin371473329608067507 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView8742527234425532782 where mk.movie_id=aggView8742527234425532782.v40);
create or replace view aggJoin7732094648338667475 as (
with aggView6109142720939467969 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin3415242973443699591 join aggView6109142720939467969 using(v23));
create or replace view aggJoin1103213041609713043 as (
with aggView3593993286699568256 as (select v40 from aggJoin7732094648338667475 group by v40)
select v41, v44 from aggJoin4677352561229533879 join aggView3593993286699568256 using(v40));
create or replace view aggView3760165462222996546 as select v41 from aggJoin1103213041609713043 group by v41;
select MIN(v41) as v52 from aggView3760165462222996546;
