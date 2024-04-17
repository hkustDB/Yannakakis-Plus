create or replace view aggView7445835963364175117 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin7532596105526956853 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView7445835963364175117 where mi_idx.movie_id=aggView7445835963364175117.v15;
create or replace view aggView3376120699293147834 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin4815428627577353586 as select v15, v28, v29 from aggJoin7532596105526956853 join aggView3376120699293147834 using(v3);
create or replace view aggView4268510248866611975 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin4815428627577353586 group by v15,v28,v29;
create or replace view aggJoin4025616618543503285 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView4268510248866611975 where mc.movie_id=aggView4268510248866611975.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5586376168801978056 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3309624285446339947 as select v9, v28, v29 from aggJoin4025616618543503285 join aggView5586376168801978056 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3309624285446339947;
