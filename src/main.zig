const std = @import("std");
const Allocator = std.mem.Allocator;
const math = std.math;

const vector = struct {
    x: f32,
    y: f32,

    fn deinit(self: vector, allocator: Allocator) void {
        allocator.free(self.name);
    }
};

pub fn main() !void {
    var vec1 = vector{ .x = 0, .y = 0 };
    var vec2 = vector{ .x = 0, .y = 0 };

    // Get allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    // Parse args into string array (error union needs 'try')
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    // Get and print them!
    std.debug.print("There are {d} args:\n", .{args.len});
    defer vec1.deinit(allocator);
    defer vec2.deinit(allocator);
    vec1.x = @as(i32, args[1]);
    vec1.y = @as(i32, args[2]);
    vec2.x = @as(i32, args[3]);
    vec2.y = @as(i32, args[4]);

    const mag1 = (vec1.x * vec1.x) + (vec1.y * vec1.y);
    const mag2 = (vec2.x * vec2.x) + (vec2.y * vec2.y);
    const dot1 = vec1.x * vec2.x + vec1.y * vec2.y;

    const degrees: f32 = math.radiansToDegrees(math.acos((mag1 * mag2) / dot1));

    std.debug.print("The angle is {}", .{degrees});
}
