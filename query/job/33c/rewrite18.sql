create or replace view aggView8522167371486941922 as select name as v2, id as v1 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView228202922622853210 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggJoin2720103186567325521 as (
with aggView912879443518566599 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView912879443518566599 where mi_idx2.info_type_id=aggView912879443518566599.v17);
create or replace view aggJoin1953545639307599843 as (
with aggView4422303753004771757 as (select v61, v43 from aggJoin2720103186567325521 group by v61,v43)
select v61, v43 from aggView4422303753004771757 where v43<'3.5');
create or replace view aggJoin1242023024488950701 as (
with aggView4288581374098670245 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView4288581374098670245 where t2.kind_id=aggView4288581374098670245.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView3006816416439245410 as select v61, v62 from aggJoin1242023024488950701 group by v61,v62;
create or replace view aggJoin8095395881285713677 as (
with aggView8613355528278223841 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView8613355528278223841 where t1.kind_id=aggView8613355528278223841.v19);
create or replace view aggView6788786039241451225 as select v50, v49 from aggJoin8095395881285713677 group by v50,v49;
create or replace view aggJoin2254948913876523458 as (
with aggView2591160592806207141 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2591160592806207141 where mi_idx1.info_type_id=aggView2591160592806207141.v15);
create or replace view aggView4273150754145930990 as select v38, v49 from aggJoin2254948913876523458 group by v38,v49;
create or replace view aggJoin3263061357622737929 as (
with aggView5524440434766535130 as (select v49, MIN(v50) as v77 from aggView6788786039241451225 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v77 from movie_link as ml, aggView5524440434766535130 where ml.movie_id=aggView5524440434766535130.v49);
create or replace view aggJoin1584257626100368748 as (
with aggView1693866070475768212 as (select v8, MIN(v9) as v74 from aggView228202922622853210 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView1693866070475768212 where mc2.company_id=aggView1693866070475768212.v8);
create or replace view aggJoin956195929930729761 as (
with aggView3357431202736561505 as (select v61, MIN(v43) as v76 from aggJoin1953545639307599843 group by v61)
select v49, v61, v23, v77 as v77, v76 from aggJoin3263061357622737929 join aggView3357431202736561505 using(v61));
create or replace view aggJoin4733980555022185412 as (
with aggView4865429684683848994 as (select v61, MIN(v62) as v78 from aggView3006816416439245410 group by v61)
select v49, v61, v23, v77 as v77, v76 as v76, v78 from aggJoin956195929930729761 join aggView4865429684683848994 using(v61));
create or replace view aggJoin5504781944578633171 as (
with aggView5041789462036260794 as (select v49, MIN(v38) as v75 from aggView4273150754145930990 group by v49)
select movie_id as v49, company_id as v1, v75 from movie_companies as mc1, aggView5041789462036260794 where mc1.movie_id=aggView5041789462036260794.v49);
create or replace view aggJoin2437348410143033492 as (
with aggView7190372048451945475 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v77, v76, v78 from aggJoin4733980555022185412 join aggView7190372048451945475 using(v23));
create or replace view aggJoin4859129895527098772 as (
with aggView3107138019335671502 as (select v61, MIN(v74) as v74 from aggJoin1584257626100368748 group by v61,v74)
select v49, v77 as v77, v76 as v76, v78 as v78, v74 from aggJoin2437348410143033492 join aggView3107138019335671502 using(v61));
create or replace view aggJoin3170454152655292818 as (
with aggView4843671226722918147 as (select v49, MIN(v77) as v77, MIN(v76) as v76, MIN(v78) as v78, MIN(v74) as v74 from aggJoin4859129895527098772 group by v49,v74,v77,v76,v78)
select v1, v75 as v75, v77, v76, v78, v74 from aggJoin5504781944578633171 join aggView4843671226722918147 using(v49));
create or replace view aggJoin1304200988864504964 as (
with aggView2493300766671146715 as (select v1, MIN(v75) as v75, MIN(v77) as v77, MIN(v76) as v76, MIN(v78) as v78, MIN(v74) as v74 from aggJoin3170454152655292818 group by v1,v75,v76,v74,v77,v78)
select v2, v75, v77, v76, v78, v74 from aggView8522167371486941922 join aggView2493300766671146715 using(v1));
select MIN(v2) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin1304200988864504964;
