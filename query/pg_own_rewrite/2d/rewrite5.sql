create or replace view aggView5936497038502979232 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3755942733015206082 as select movie_id as v12 from movie_companies as mc, aggView5936497038502979232 where mc.company_id=aggView5936497038502979232.v1;
create or replace view aggView6577835716171750041 as select v12 from aggJoin3755942733015206082 group by v12;
create or replace view aggJoin3427580586837020560 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView6577835716171750041 where mk.movie_id=aggView6577835716171750041.v12;
create or replace view aggView4778049608101626787 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6977193909912963710 as select v12 from aggJoin3427580586837020560 join aggView4778049608101626787 using(v18);
create or replace view aggView2590393536400268826 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3532304272199695018 as select v31 from aggJoin6977193909912963710 join aggView2590393536400268826 using(v12);
select MIN(v31) as v31 from aggJoin3532304272199695018;
