create or replace view aggView5760855468103559965 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4185759600536238197 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5760855468103559965 where mi_idx.info_type_id=aggView5760855468103559965.v3;
create or replace view aggView7382725931285629321 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1567782384328096606 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7382725931285629321 where mc.company_type_id=aggView7382725931285629321.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView8614932944602914548 as select v15, MIN(v9) as v27 from aggJoin1567782384328096606 group by v15;
create or replace view aggJoin3955627643938890378 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView8614932944602914548 where t.id=aggView8614932944602914548.v15;
create or replace view aggView7305559305513264887 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3955627643938890378 group by v15;
create or replace view aggJoin260221155986494664 as select v27, v28, v29 from aggJoin4185759600536238197 join aggView7305559305513264887 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin260221155986494664;
