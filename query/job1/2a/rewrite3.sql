create or replace view aggView3523917569113245617 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6187174176690400421 as select movie_id as v12 from movie_keyword as mk, aggView3523917569113245617 where mk.keyword_id=aggView3523917569113245617.v18;
create or replace view aggView5666068953711088861 as select v12 from aggJoin6187174176690400421 group by v12;
create or replace view aggJoin3703237150988774034 as select id as v12, title as v20 from title as t, aggView5666068953711088861 where t.id=aggView5666068953711088861.v12;
create or replace view aggView1412501589551931883 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin5178321495121503805 as select movie_id as v12 from movie_companies as mc, aggView1412501589551931883 where mc.company_id=aggView1412501589551931883.v1;
create or replace view aggView4914318566331905134 as select v12 from aggJoin5178321495121503805 group by v12;
create or replace view aggJoin3374006952068590239 as select v20 from aggJoin3703237150988774034 join aggView4914318566331905134 using(v12);
select MIN(v20) as v31 from aggJoin3374006952068590239;
