create or replace view aggView2057169830515961714 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin7614880872334281907 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView2057169830515961714 where mi_idx.movie_id=aggView2057169830515961714.v15;
create or replace view aggView9025315849539064801 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4975353398623732213 as select v15, v28, v29 from aggJoin7614880872334281907 join aggView9025315849539064801 using(v3);
create or replace view aggView3202545723042009039 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin4975353398623732213 group by v15,v29,v28;
create or replace view aggJoin4374468790100079504 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView3202545723042009039 where mc.movie_id=aggView3202545723042009039.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5031367127768820872 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4087639103286318479 as select v9, v28, v29 from aggJoin4374468790100079504 join aggView5031367127768820872 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4087639103286318479;
