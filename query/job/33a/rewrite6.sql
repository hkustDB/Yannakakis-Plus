create or replace view aggView1697328894687078824 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggView9042467079091878131 as select id as v1, name as v2 from company_name as cn1 where country_code= '[us]';
create or replace view aggJoin5032030965236414191 as (
with aggView7349572859213973617 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView7349572859213973617 where t2.kind_id=aggView7349572859213973617.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggView796381397032198415 as select v61, v62 from aggJoin5032030965236414191 group by v61,v62;
create or replace view aggJoin4263093998978574590 as (
with aggView5536932920936428420 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView5536932920936428420 where t1.kind_id=aggView5536932920936428420.v19);
create or replace view aggView163524430679100787 as select v49, v50 from aggJoin4263093998978574590 group by v49,v50;
create or replace view aggJoin6018861598348120066 as (
with aggView3705912084876846982 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView3705912084876846982 where mi_idx2.info_type_id=aggView3705912084876846982.v17 and info<'3.0');
create or replace view aggView1495332989552208367 as select v61, v43 from aggJoin6018861598348120066 group by v61,v43;
create or replace view aggJoin6219197082640257113 as (
with aggView4538869762919364410 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView4538869762919364410 where mi_idx1.info_type_id=aggView4538869762919364410.v15);
create or replace view aggView2244389076116282154 as select v49, v38 from aggJoin6219197082640257113 group by v49,v38;
create or replace view aggJoin877650993725017706 as (
with aggView5743912176740770377 as (select v49, MIN(v38) as v75 from aggView2244389076116282154 group by v49)
select movie_id as v49, company_id as v1, v75 from movie_companies as mc1, aggView5743912176740770377 where mc1.movie_id=aggView5743912176740770377.v49);
create or replace view aggJoin4155130582217381393 as (
with aggView4810834046946947196 as (select v8, MIN(v9) as v74 from aggView1697328894687078824 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView4810834046946947196 where mc2.company_id=aggView4810834046946947196.v8);
create or replace view aggJoin2181715910328356352 as (
with aggView4600322534519172851 as (select v1, MIN(v2) as v73 from aggView9042467079091878131 group by v1)
select v49, v75 as v75, v73 from aggJoin877650993725017706 join aggView4600322534519172851 using(v1));
create or replace view aggJoin6860924922547990318 as (
with aggView9147525734509458227 as (select v61, MIN(v62) as v78 from aggView796381397032198415 group by v61)
select v61, v43, v78 from aggView1495332989552208367 join aggView9147525734509458227 using(v61));
create or replace view aggJoin7950140588873004412 as (
with aggView8716038347866437826 as (select v61, MIN(v78) as v78, MIN(v43) as v76 from aggJoin6860924922547990318 group by v61,v78)
select v61, v74 as v74, v78, v76 from aggJoin4155130582217381393 join aggView8716038347866437826 using(v61));
create or replace view aggJoin4417819601624443558 as (
with aggView1887048989207378916 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView1887048989207378916 where ml.link_type_id=aggView1887048989207378916.v23);
create or replace view aggJoin4008728687406458122 as (
with aggView1006627531695293376 as (select v49, MIN(v75) as v75, MIN(v73) as v73 from aggJoin2181715910328356352 group by v49,v75,v73)
select v49, v61, v75, v73 from aggJoin4417819601624443558 join aggView1006627531695293376 using(v49));
create or replace view aggJoin1709220080814415287 as (
with aggView9103760994304788424 as (select v61, MIN(v74) as v74, MIN(v78) as v78, MIN(v76) as v76 from aggJoin7950140588873004412 group by v61,v74,v76,v78)
select v49, v75 as v75, v73 as v73, v74, v78, v76 from aggJoin4008728687406458122 join aggView9103760994304788424 using(v61));
create or replace view aggJoin6146824536136300289 as (
with aggView8993475439051980163 as (select v49, MIN(v75) as v75, MIN(v73) as v73, MIN(v74) as v74, MIN(v78) as v78, MIN(v76) as v76 from aggJoin1709220080814415287 group by v49,v73,v75,v78,v76,v74)
select v50, v75, v73, v74, v78, v76 from aggView163524430679100787 join aggView8993475439051980163 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v50) as v77,MIN(v78) as v78 from aggJoin6146824536136300289;
