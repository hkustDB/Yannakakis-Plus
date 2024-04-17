create or replace view aggView5897224784427620609 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3310440004786583969 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView5897224784427620609 where mk.movie_id=aggView5897224784427620609.v12;
create or replace view aggView550715924675174782 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin7189803693834677732 as select movie_id as v12 from movie_companies as mc, aggView550715924675174782 where mc.company_id=aggView550715924675174782.v1;
create or replace view aggView5446787510147801919 as select v12 from aggJoin7189803693834677732 group by v12;
create or replace view aggJoin6918813006016406291 as select v18, v31 as v31 from aggJoin3310440004786583969 join aggView5446787510147801919 using(v12);
create or replace view aggView3505163261888020756 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3535336241094267765 as select v31 from aggJoin6918813006016406291 join aggView3505163261888020756 using(v18);
select MIN(v31) as v31 from aggJoin3535336241094267765;
