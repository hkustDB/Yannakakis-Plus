create or replace view aggView6616970785111197568 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin4669057415959825791 as select movie_id as v12 from movie_companies as mc, aggView6616970785111197568 where mc.company_id=aggView6616970785111197568.v1;
create or replace view aggView8180784384672099370 as select v12 from aggJoin4669057415959825791 group by v12;
create or replace view aggJoin4907567089152814698 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView8180784384672099370 where mk.movie_id=aggView8180784384672099370.v12;
create or replace view aggView1380565256931650809 as select id as v12, title as v31 from title as t;
create or replace view aggJoin1204019711396982193 as select v18, v31 from aggJoin4907567089152814698 join aggView1380565256931650809 using(v12);
create or replace view aggView474623831274653819 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8156147942488774052 as select v31 from aggJoin1204019711396982193 join aggView474623831274653819 using(v18);
select MIN(v31) as v31 from aggJoin8156147942488774052;
