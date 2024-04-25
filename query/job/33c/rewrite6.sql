create or replace view aggView2744871481179056505 as select id as v1, name as v2 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView8466060840276381594 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggJoin4714520935246484944 as (
with aggView7913969437280818748 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView7913969437280818748 where mi_idx1.info_type_id=aggView7913969437280818748.v15);
create or replace view aggView1356359388478947515 as select v49, v38 from aggJoin4714520935246484944 group by v49,v38;
create or replace view aggJoin2945853283732137276 as (
with aggView1672792393014540779 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView1672792393014540779 where t2.kind_id=aggView1672792393014540779.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView4200291733356853370 as select v62, v61 from aggJoin2945853283732137276 group by v62,v61;
create or replace view aggJoin2641636627415685995 as (
with aggView7293873381750091191 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView7293873381750091191 where t1.kind_id=aggView7293873381750091191.v19);
create or replace view aggView4932257631718193073 as select v50, v49 from aggJoin2641636627415685995 group by v50,v49;
create or replace view aggJoin8501847638777686903 as (
with aggView5625761743155563701 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView5625761743155563701 where mi_idx2.info_type_id=aggView5625761743155563701.v17);
create or replace view aggJoin1293085594092544041 as (
with aggView9046183512450561281 as (select v61, v43 from aggJoin8501847638777686903 group by v61,v43)
select v61, v43 from aggView9046183512450561281 where v43<'3.5');
create or replace view aggJoin5425073043998485155 as (
with aggView7048667408831611686 as (select v8, MIN(v9) as v74 from aggView8466060840276381594 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView7048667408831611686 where mc2.company_id=aggView7048667408831611686.v8);
create or replace view aggJoin7943875875195128961 as (
with aggView5061034834061457101 as (select v61, MIN(v62) as v78 from aggView4200291733356853370 group by v61)
select v61, v43, v78 from aggJoin1293085594092544041 join aggView5061034834061457101 using(v61));
create or replace view aggJoin3045847869747084862 as (
with aggView1293167058156952168 as (select v1, MIN(v2) as v73 from aggView2744871481179056505 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView1293167058156952168 where mc1.company_id=aggView1293167058156952168.v1);
create or replace view aggJoin6596492416580468848 as (
with aggView3131459027509906226 as (select v61, MIN(v78) as v78, MIN(v43) as v76 from aggJoin7943875875195128961 group by v61)
select v61, v74 as v74, v78, v76 from aggJoin5425073043998485155 join aggView3131459027509906226 using(v61));
create or replace view aggJoin4718703216458473034 as (
with aggView859950369271058524 as (select v49, MIN(v38) as v75 from aggView1356359388478947515 group by v49)
select v49, v73 as v73, v75 from aggJoin3045847869747084862 join aggView859950369271058524 using(v49));
create or replace view aggJoin6938488236892172577 as (
with aggView3132231016878472209 as (select v49, MIN(v73) as v73, MIN(v75) as v75 from aggJoin4718703216458473034 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v73, v75 from movie_link as ml, aggView3132231016878472209 where ml.movie_id=aggView3132231016878472209.v49);
create or replace view aggJoin7341970676883198410 as (
with aggView48401155211527360 as (select v61, MIN(v74) as v74, MIN(v78) as v78, MIN(v76) as v76 from aggJoin6596492416580468848 group by v61)
select v49, v23, v73 as v73, v75 as v75, v74, v78, v76 from aggJoin6938488236892172577 join aggView48401155211527360 using(v61));
create or replace view aggJoin5527054866880918536 as (
with aggView1011063765456983031 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v73, v75, v74, v78, v76 from aggJoin7341970676883198410 join aggView1011063765456983031 using(v23));
create or replace view aggJoin764530126601131941 as (
with aggView2316294436335687364 as (select v49, MIN(v73) as v73, MIN(v75) as v75, MIN(v74) as v74, MIN(v78) as v78, MIN(v76) as v76 from aggJoin5527054866880918536 group by v49)
select v50, v73, v75, v74, v78, v76 from aggView4932257631718193073 join aggView2316294436335687364 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v50) as v77,MIN(v78) as v78 from aggJoin764530126601131941;
