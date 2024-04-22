create or replace view aggView6286741398333529349 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin330798062428636907 as (
with aggView2288835670059388292 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2288835670059388292 where mi_idx.info_type_id=aggView2288835670059388292.v12 and info<'7.0');
create or replace view aggJoin5073922256155701238 as (
with aggView4315972183555475816 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView4315972183555475816 where t.kind_id=aggView4315972183555475816.v17 and production_year>2009);
create or replace view aggJoin6498992830687909284 as (
with aggView3252224561475600071 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView3252224561475600071 where mi.info_type_id=aggView3252224561475600071.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin1553347813118956510 as (
with aggView8528374431250080486 as (select v37 from aggJoin6498992830687909284 group by v37)
select v37, v32 from aggJoin330798062428636907 join aggView8528374431250080486 using(v37));
create or replace view aggView1567216926302768950 as select v37, v32 from aggJoin1553347813118956510 group by v37,v32;
create or replace view aggJoin8009246899528949048 as (
with aggView1604213687854909546 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView1604213687854909546 where mk.keyword_id=aggView1604213687854909546.v14);
create or replace view aggJoin4460949185930573325 as (
with aggView4610622462746020034 as (select v37 from aggJoin8009246899528949048 group by v37)
select v37, v38, v41 from aggJoin5073922256155701238 join aggView4610622462746020034 using(v37));
create or replace view aggView1557436690688375442 as select v38, v37 from aggJoin4460949185930573325 group by v38,v37;
create or replace view aggJoin7124579953206580214 as (
with aggView2507663981575072214 as (select v37, MIN(v32) as v50 from aggView1567216926302768950 group by v37)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v50 from movie_companies as mc, aggView2507663981575072214 where mc.movie_id=aggView2507663981575072214.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4969656420882884336 as (
with aggView7492640026098160326 as (select v37, MIN(v38) as v51 from aggView1557436690688375442 group by v37)
select v1, v8, v23, v50 as v50, v51 from aggJoin7124579953206580214 join aggView7492640026098160326 using(v37));
create or replace view aggJoin4773524982030489582 as (
with aggView6653045203689029953 as (select id as v8 from company_type as ct)
select v1, v23, v50, v51 from aggJoin4969656420882884336 join aggView6653045203689029953 using(v8));
create or replace view aggJoin2038916906641109754 as (
with aggView3994116011508066544 as (select v1, MIN(v50) as v50, MIN(v51) as v51 from aggJoin4773524982030489582 group by v1,v50,v51)
select v2, v50, v51 from aggView6286741398333529349 join aggView3994116011508066544 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin2038916906641109754;
