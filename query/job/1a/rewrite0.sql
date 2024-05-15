create or replace view aggView7966768696487138486 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8641981183727151378 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7966768696487138486 where mi_idx.info_type_id=aggView7966768696487138486.v3;
create or replace view aggView8152543021290295556 as select v15 from aggJoin8641981183727151378 group by v15;
create or replace view aggJoin4824702122792601851 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView8152543021290295556 where mc.movie_id=aggView8152543021290295556.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView4851260263079522764 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8880237356052378750 as select v15, v9 from aggJoin4824702122792601851 join aggView4851260263079522764 using(v1);
create or replace view aggView9114606784919518768 as select v15, MIN(v9) as v27 from aggJoin8880237356052378750 group by v15;
create or replace view aggJoin8051699179792417053 as select title as v16, production_year as v19, v27 from title as t, aggView9114606784919518768 where t.id=aggView9114606784919518768.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin8051699179792417053;
