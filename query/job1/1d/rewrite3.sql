create or replace view aggView3261178904695769337 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin878162150395222872 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3261178904695769337 where mi_idx.info_type_id=aggView3261178904695769337.v3;
create or replace view aggView829429320581563068 as select v15 from aggJoin878162150395222872 group by v15;
create or replace view aggJoin3788203371373073052 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView829429320581563068 where mc.movie_id=aggView829429320581563068.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1389064755240280528 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4006383665377286463 as select v15, v9 from aggJoin3788203371373073052 join aggView1389064755240280528 using(v1);
create or replace view aggView4923461818576968259 as select v15, MIN(v9) as v27 from aggJoin4006383665377286463 group by v15;
create or replace view aggJoin1845246251835037014 as select title as v16, production_year as v19, v27 from title as t, aggView4923461818576968259 where t.id=aggView4923461818576968259.v15 and production_year>2000;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin1845246251835037014;
