create or replace view aggView6529133728371862542 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin4348677258690767234 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6529133728371862542 where mc.movie_id=aggView6529133728371862542.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView670164999074435537 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2599197036404928742 as select v15, v9, v28, v29 from aggJoin4348677258690767234 join aggView670164999074435537 using(v1);
create or replace view aggView1235753197391290749 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin2599197036404928742 group by v15;
create or replace view aggJoin600745858565340697 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView1235753197391290749 where mi_idx.movie_id=aggView1235753197391290749.v15;
create or replace view aggView5839530069295711137 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2512783907221921093 as select v28, v29, v27 from aggJoin600745858565340697 join aggView5839530069295711137 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2512783907221921093;
