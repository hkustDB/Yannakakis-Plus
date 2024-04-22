create or replace view aggJoin2149569255739252115 as (
with aggView4249843888681192765 as (select id as v12, title as v31 from title as t)
select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView4249843888681192765 where mk.movie_id=aggView4249843888681192765.v12);
create or replace view aggJoin4592327342036058313 as (
with aggView4854435795029707816 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v12 from movie_companies as mc, aggView4854435795029707816 where mc.company_id=aggView4854435795029707816.v1);
create or replace view aggJoin5599255109631085361 as (
with aggView177396287717972503 as (select v12 from aggJoin4592327342036058313 group by v12)
select v18, v31 as v31 from aggJoin2149569255739252115 join aggView177396287717972503 using(v12));
create or replace view aggJoin32838961426779412 as (
with aggView3307044591169645904 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v31 from aggJoin5599255109631085361 join aggView3307044591169645904 using(v18));
select MIN(v31) as v31 from aggJoin32838961426779412;
