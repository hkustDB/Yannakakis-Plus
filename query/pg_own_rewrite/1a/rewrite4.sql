create or replace view aggView5195915837073569096 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1525298151185165830 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5195915837073569096 where mc.company_type_id=aggView5195915837073569096.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView8418023497065184931 as select v15, MIN(v9) as v27 from aggJoin1525298151185165830 group by v15;
create or replace view aggJoin8967894690579385340 as select movie_id as v15, info_type_id as v3, v27 from movie_info_idx as mi_idx, aggView8418023497065184931 where mi_idx.movie_id=aggView8418023497065184931.v15;
create or replace view aggView234901375379999349 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2554768392702433749 as select v15, v27 from aggJoin8967894690579385340 join aggView234901375379999349 using(v3);
create or replace view aggView3273842884779103860 as select v15, MIN(v27) as v27 from aggJoin2554768392702433749 group by v15,v27;
create or replace view aggJoin4593716321236111316 as select title as v16, production_year as v19, v27 from title as t, aggView3273842884779103860 where t.id=aggView3273842884779103860.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin4593716321236111316;
