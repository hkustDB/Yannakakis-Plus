create or replace view aggView4043682069497014848 as select name as v2, id as v1 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView1298332536460312784 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggJoin2683583131538448473 as (
with aggView3874515370380388641 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView3874515370380388641 where mi_idx2.info_type_id=aggView3874515370380388641.v17);
create or replace view aggJoin2982879773746467577 as (
with aggView637654211435941564 as (select v61, v43 from aggJoin2683583131538448473 group by v61,v43)
select v61, v43 from aggView637654211435941564 where v43<'3.5');
create or replace view aggJoin8915358248075992461 as (
with aggView3144420835344222245 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView3144420835344222245 where t1.kind_id=aggView3144420835344222245.v19);
create or replace view aggView1491484666018198566 as select v50, v49 from aggJoin8915358248075992461 group by v50,v49;
create or replace view aggJoin4179668540705069175 as (
with aggView1771401963561618928 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView1771401963561618928 where t2.kind_id=aggView1771401963561618928.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView4541303258396641661 as select v61, v62 from aggJoin4179668540705069175 group by v61,v62;
create or replace view aggJoin231941585352180198 as (
with aggView3948787535583192225 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView3948787535583192225 where mi_idx1.info_type_id=aggView3948787535583192225.v15);
create or replace view aggView8954396590293678707 as select v38, v49 from aggJoin231941585352180198 group by v38,v49;
create or replace view aggJoin1511960969435607197 as (
with aggView6867699442555554823 as (select v1, MIN(v2) as v73 from aggView4043682069497014848 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView6867699442555554823 where mc1.company_id=aggView6867699442555554823.v1);
create or replace view aggJoin5610345057120146305 as (
with aggView6817299532786444802 as (select v49, MIN(v50) as v77 from aggView1491484666018198566 group by v49)
select v49, v73 as v73, v77 from aggJoin1511960969435607197 join aggView6817299532786444802 using(v49));
create or replace view aggJoin5600634914525187697 as (
with aggView9072070151345853695 as (select v8, MIN(v9) as v74 from aggView1298332536460312784 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView9072070151345853695 where mc2.company_id=aggView9072070151345853695.v8);
create or replace view aggJoin4951031951043059979 as (
with aggView376430144205484170 as (select v61, MIN(v62) as v78 from aggView4541303258396641661 group by v61)
select v61, v43, v78 from aggJoin2982879773746467577 join aggView376430144205484170 using(v61));
create or replace view aggJoin7876832162667894828 as (
with aggView7711906427580905249 as (select v49, MIN(v38) as v75 from aggView8954396590293678707 group by v49)
select v49, v73 as v73, v77 as v77, v75 from aggJoin5610345057120146305 join aggView7711906427580905249 using(v49));
create or replace view aggJoin1910191409446619007 as (
with aggView903036344130465879 as (select v49, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin7876832162667894828 group by v49,v77,v75,v73)
select linked_movie_id as v61, link_type_id as v23, v73, v77, v75 from movie_link as ml, aggView903036344130465879 where ml.movie_id=aggView903036344130465879.v49);
create or replace view aggJoin6424100457046267997 as (
with aggView1442616525603239709 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v73, v77, v75 from aggJoin1910191409446619007 join aggView1442616525603239709 using(v23));
create or replace view aggJoin8685840043728489004 as (
with aggView7560941194854687792 as (select v61, MIN(v74) as v74 from aggJoin5600634914525187697 group by v61,v74)
select v61, v73 as v73, v77 as v77, v75 as v75, v74 from aggJoin6424100457046267997 join aggView7560941194854687792 using(v61));
create or replace view aggJoin512853006858894636 as (
with aggView3721315314990493723 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75, MIN(v74) as v74 from aggJoin8685840043728489004 group by v61,v74,v77,v75,v73)
select v43, v78 as v78, v73, v77, v75, v74 from aggJoin4951031951043059979 join aggView3721315314990493723 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v43) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin512853006858894636;
