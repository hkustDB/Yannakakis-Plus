create or replace view aggView5381240493734053712 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin6941470532774466378 as select movie_id as v12 from movie_companies as mc, aggView5381240493734053712 where mc.company_id=aggView5381240493734053712.v1;
create or replace view aggView6117897092801643867 as select v12 from aggJoin6941470532774466378 group by v12;
create or replace view aggJoin8850535907462413669 as select id as v12, title as v20 from title as t, aggView6117897092801643867 where t.id=aggView6117897092801643867.v12;
create or replace view aggView2505169981922012072 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8357552438374261248 as select movie_id as v12 from movie_keyword as mk, aggView2505169981922012072 where mk.keyword_id=aggView2505169981922012072.v18;
create or replace view aggView8647127306386496905 as select v12, MIN(v20) as v31 from aggJoin8850535907462413669 group by v12;
create or replace view aggJoin3557211433610375218 as select v31 from aggJoin8357552438374261248 join aggView8647127306386496905 using(v12);
select MIN(v31) as v31 from aggJoin3557211433610375218;
