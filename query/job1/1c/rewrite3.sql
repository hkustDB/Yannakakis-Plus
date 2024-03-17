create or replace view aggView4293244409209498632 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin6933527603740429203 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView4293244409209498632 where mc.movie_id=aggView4293244409209498632.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4894693666360802072 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3920389852442037354 as select v15, v9, v28, v29 from aggJoin6933527603740429203 join aggView4894693666360802072 using(v1);
create or replace view aggView8374735218687319882 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin3920389852442037354 group by v15;
create or replace view aggJoin3802450845188548180 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView8374735218687319882 where mi_idx.movie_id=aggView8374735218687319882.v15;
create or replace view aggView393755566488164082 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin3802450845188548180 group by v3;
create or replace view aggJoin4097988499217703663 as select info as v4, v28, v29, v27 from info_type as it, aggView393755566488164082 where it.id=aggView393755566488164082.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4097988499217703663;
