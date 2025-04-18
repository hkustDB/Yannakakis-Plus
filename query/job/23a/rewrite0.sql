create or replace view aggView3769691774146170329 as select id as v16 from info_type as it1 where info= 'release dates';
create or replace view aggJoin6255856599009650394 as select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView3769691774146170329 where mi.info_type_id=aggView3769691774146170329.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%';
create or replace view aggView8293180124597189031 as select id as v21, kind as v48 from kind_type as kt where kind= 'movie';
create or replace view aggJoin4046738512513563382 as select id as v36, title as v37, production_year as v40, v48 from title as t, aggView8293180124597189031 where t.kind_id=aggView8293180124597189031.v21 and production_year>2000;
create or replace view aggView9069053271027984018 as select v36 from aggJoin6255856599009650394 group by v36;
create or replace view aggJoin2456820529598237177 as select v36, v37, v40, v48 as v48 from aggJoin4046738512513563382 join aggView9069053271027984018 using(v36);
create or replace view aggView2210706399460783849 as select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin2456820529598237177 group by v36;
create or replace view aggJoin1771076865474467675 as select movie_id as v36, status_id as v5, v48, v49 from complete_cast as cc, aggView2210706399460783849 where cc.movie_id=aggView2210706399460783849.v36;
create or replace view aggView2482628982634990097 as select v36, v5, MIN(v48) as v48, MIN(v49) as v49 from aggJoin1771076865474467675 group by v36,v5;
create or replace view aggJoin2189536455013998004 as select movie_id as v36, company_id as v7, company_type_id as v14, v5, v48, v49 from movie_companies as mc, aggView2482628982634990097 where mc.movie_id=aggView2482628982634990097.v36;
create or replace view aggView3718556672330170677 as select v14, v7, v5, v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin2189536455013998004 group by v14,v7,v5,v36;
create or replace view aggJoin4803407110988086514 as select v7, v5, v36, v48, v49 from company_type as ct, aggView3718556672330170677 where ct.id=aggView3718556672330170677.v14;
create or replace view aggView2390230567425673789 as select v36, v7, v5, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4803407110988086514 group by v36,v7,v5;
create or replace view aggJoin4237598506983284651 as select movie_id as v36, keyword_id as v18, v7, v5, v48, v49 from movie_keyword as mk, aggView2390230567425673789 where mk.movie_id=aggView2390230567425673789.v36;
create or replace view aggView5456749450265258054 as select v7, v5, v18, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4237598506983284651 group by v7,v5,v18;
create or replace view aggJoin3869456826165609670 as select id as v7, country_code as v9, v5, v18, v48, v49 from company_name as cn, aggView5456749450265258054 where cn.id=aggView5456749450265258054.v7 and country_code= '[us]';
create or replace view aggView6413280799745391363 as select v18, v5, MIN(v48) as v48, MIN(v49) as v49 from aggJoin3869456826165609670 group by v18,v5;
create or replace view aggJoin2116320517049428054 as select id as v18, v5, v48, v49 from keyword as k, aggView6413280799745391363 where k.id=aggView6413280799745391363.v18;
create or replace view aggView4431147697715800255 as select v5, MIN(v48) as v48, MIN(v49) as v49 from aggJoin2116320517049428054 group by v5;
create or replace view aggJoin7776383545250313220 as select id as v5, kind as v6, v48, v49 from comp_cast_type as cct1, aggView4431147697715800255 where cct1.id=aggView4431147697715800255.v5 and kind= 'complete+verified';
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin7776383545250313220;
